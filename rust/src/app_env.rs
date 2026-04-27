use std::sync::OnceLock;

static APPLICATION_SUPPORT_DIRECTORY: OnceLock<String> = OnceLock::new();

pub fn init_app_env(application_support_directory: &str) -> anyhow::Result<()> {
    match APPLICATION_SUPPORT_DIRECTORY.set(application_support_directory.to_string()) {
        Ok(_) => Ok(()),
        Err(e) => Err(anyhow::anyhow!(
            "Failed to set application support directory: {e}"
        )),
    }
}

pub fn get_app_support_directory() -> anyhow::Result<&'static str> {
    match APPLICATION_SUPPORT_DIRECTORY.get() {
        Some(s) => Ok(s.as_str()),
        None => Err(anyhow::anyhow!(
            "Application support directory not initialized"
        )),
    }
}
