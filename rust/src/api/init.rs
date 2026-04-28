use std::{fs, path::Path};

use anyhow::Context;
use migration::{Migrator, MigratorTrait};

use crate::{
    app_env::{get_app_support_directory, init_app_env},
    clean_error::CleanError,
    factory::create_db_connection,
    logger::init_logger,
};

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[flutter_rust_bridge::frb(sync)]
pub fn init_path(application_support_directory: String) -> Result<(), CleanError> {
    eprintln!(
        "Initializing application with support directory: {}",
        application_support_directory
    );
    fs::create_dir_all(&application_support_directory)
        .map_err(|e| anyhow::anyhow!("Failed to create application support directory: {e}"))?;
    init_app_env(&application_support_directory)?;
    Ok(())
}

#[flutter_rust_bridge::frb(sync)]
pub fn init_rust_logger() -> Result<(), CleanError> {
    let log_dir = Path::new(&get_app_support_directory()?).join("logs");
    let log_dir = log_dir
        .to_str()
        .ok_or_else(|| anyhow::anyhow!("Failed to construct log directory path"))?;
    init_logger(4, log_dir)?;
    Ok(())
}

#[flutter_rust_bridge::frb]
pub async fn init_migrate() -> Result<(), CleanError> {
    let db = create_db_connection().await?;
    Migrator::up(&db, None)
        .await
        .context("Failed to perform database migration")?;
    Ok(())
}
