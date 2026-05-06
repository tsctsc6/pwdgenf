use anyhow::anyhow;

static MAX_KEY_COUNT: usize = 0xFFFF;

pub struct KeystreamProvider {
    cipher: Box<dyn cipher::StreamCipher>,
    keystream_buffer: Vec<u8>,
    pointer: usize,
    pub key_count: usize,
}

impl KeystreamProvider {
    pub fn new(mut cipher: Box<dyn cipher::StreamCipher>) -> Self {
        let mut keystream_buffer: Vec<u8> = vec![0, 64];
        cipher.apply_keystream(&mut keystream_buffer);
        KeystreamProvider {
            cipher,
            keystream_buffer,
            pointer: 0,
            key_count: 0,
        }
    }

    pub fn get_next_key(&mut self) -> anyhow::Result<u8> {
        if self.pointer >= self.keystream_buffer.len() {
            self.get_next_keystream();
            self.pointer = 0;
        }
        self.pointer = self.pointer + 1;
        self.key_count = self.key_count + 1;
        if self.key_count == MAX_KEY_COUNT {
            Err(anyhow!("reach MAX_KEY_COUNT"))?;
        }
        Ok(self.keystream_buffer[self.pointer - 1])
    }

    fn get_next_keystream(&mut self) {
        for i in self.keystream_buffer.iter_mut() {
            *i = 0;
        }
        self.cipher.apply_keystream(&mut *self.keystream_buffer);
    }
}
