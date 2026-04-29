use crate::{clean_error::CleanError, keystream_provider::KeystreamProvider};
use anyhow::anyhow;
use anyhow::Context;
use chacha20::cipher::KeyIvInit;
use chacha20::ChaCha20;
use serde::Deserialize;
use sha2::{Digest, Sha256};

static UP_LETTER: [char; 26] = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
    'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
];
static LOW_LETTER: [char; 26] = [
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
    't', 'u', 'v', 'w', 'x', 'y', 'z',
];
static NUMBER: [char; 10] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
static SP_CHAR: [char; 15] = [
    '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '-', '=',
];

#[derive(Deserialize)]
pub struct Request {
    pub user_name: String,
    pub platform: String,
    pub nonce_offset: u32,
    pub use_up_letter: bool,
    pub use_low_letter: bool,
    pub use_number: bool,
    pub use_sp_char: bool,
    pub pwd_len: u32,
    pub main_password: String,
}

pub fn validate(request: &Request) -> anyhow::Result<()> {
    if request.user_name.is_empty() {
        Err(anyhow!("user_name is empty"))?;
    }

    if request.platform.is_empty() {
        Err(anyhow!("platform is empty"))?;
    }

    if request.nonce_offset >= 20 {
        Err(anyhow!("nonce_offset is too big"))?;
    }

    if request.pwd_len > 255 {
        Err(anyhow!("pwd_len is too long"))?;
    }

    if request.main_password.is_empty() {
        Err(anyhow!("main_password is empty"))?;
    }

    Ok(())
}

#[flutter_rust_bridge::frb]
pub async fn calculate_password(request: Request) -> Result<String, CleanError> {
    validate(&request)?;
    let hash = Sha256::digest(
        [
            request.user_name.as_bytes(),
            request.platform.as_bytes(),
            request.main_password.as_bytes(),
        ]
        .concat(),
    )
    .to_vec();

    let nonce_offset = request.nonce_offset as usize;
    // key is hash, nonce is hash first 96 bits.
    let mut keystream_provider = KeystreamProvider::new(Box::new(
        ChaCha20::new_from_slices(&hash, &hash[nonce_offset..nonce_offset + 12])
            .context("Failed to create ChaCha20 cipher")?,
    ));

    let mut string_builder: Vec<char> = vec![];

    for _ in 0..request.pwd_len {
        let char_set = loop {
            let key = keystream_provider.get_next_key()?;
            let char_set: &[char] = match key % 4 {
                0 => {
                    if request.use_up_letter {
                        &UP_LETTER
                    } else {
                        &[]
                    }
                }
                1 => {
                    if request.use_low_letter {
                        &LOW_LETTER
                    } else {
                        &[]
                    }
                }
                2 => {
                    if request.use_number {
                        &NUMBER
                    } else {
                        &[]
                    }
                }
                3 => {
                    if request.use_sp_char {
                        &SP_CHAR
                    } else {
                        &[]
                    }
                }
                _ => &[],
            };
            if char_set.len() != 0 {
                break char_set;
            }
        };
        let char = loop {
            let key = keystream_provider.get_next_key()?;
            break match uniformly_pick(char_set, key as usize) {
                None => continue,
                Some(char) => char,
            };
        };
        string_builder.push(char);
    }
    Ok(string_builder.iter().collect())
}

fn uniformly_pick(char_set: &[char], key: usize) -> Option<char> {
    if key >= ((256 / char_set.len()) * char_set.len()) {
        return None;
    }
    Some(char_set[key % char_set.len()])
}
