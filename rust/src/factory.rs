use sea_orm::{Database, DatabaseConnection};
use tokio::fs;

pub fn get_db_file_path(app_support_directory: &str) -> anyhow::Result<String> {
    Ok(format!("{}/pwdgenf.db", app_support_directory))
}

pub async fn create_db_connection(
    app_support_directory: &str,
) -> anyhow::Result<DatabaseConnection> {
    let db_file_path = get_db_file_path(app_support_directory)?;
    fs::create_dir_all(&app_support_directory).await?;
    Ok(Database::connect(format!("sqlite://{}?mode=rwc", db_file_path)).await?)
}
