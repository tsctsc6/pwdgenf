use std::{fs, path::Path};

use crate::{
    app_env::{get_app_support_directory, init_app_env},
    logger::init_logger,
};

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[flutter_rust_bridge::frb(sync)]
pub fn init_path(application_support_directory: String) -> anyhow::Result<()> {
    eprintln!(
        "Initializing application with support directory: {}",
        application_support_directory
    );
    fs::create_dir_all(&application_support_directory)
        .map_err(|e| anyhow::anyhow!("Failed to create application support directory: {e}"))?;
    init_app_env(&application_support_directory)
}

#[flutter_rust_bridge::frb(sync)]
pub fn init_rust_logger() -> anyhow::Result<()> {
    let log_dir = Path::new(&get_app_support_directory()?).join("logs");
    let log_dir = log_dir
        .to_str()
        .ok_or_else(|| anyhow::anyhow!("Failed to construct log directory path"))?;
    init_logger(4, log_dir)
}
