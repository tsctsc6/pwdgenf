use sea_orm::{Database, DatabaseConnection};
use tokio::fs;

use crate::app_env::get_app_support_directory;

pub fn get_db_file_path() -> anyhow::Result<String> {
    Ok(format!("{}/pwdgenf.db", get_app_support_directory()?))
}

pub async fn create_db_connection() -> anyhow::Result<DatabaseConnection> {
    let app_data_path = get_app_support_directory()?;
    fs::create_dir_all(&app_data_path).await?;
    Ok(Database::connect(format!("sqlite://{}/pwdgenf.db?mode=rwc", app_data_path)).await?)
}
