use std::fmt::Write;

#[derive(Debug, thiserror::Error)]
pub enum CleanError {
    #[error("{message}")]
    AnyhowError { message: String },
}

impl From<anyhow::Error> for CleanError {
    fn from(err: anyhow::Error) -> Self {
        let mut full_message = String::new();
        for (i, cause) in err.chain().enumerate() {
            if i == 0 {
                let _ = write!(&mut full_message, "{}", cause);
            } else {
                let _ = write!(&mut full_message, "({})", cause);
            }
        }

        CleanError::AnyhowError {
            message: full_message,
        }
    }
}
