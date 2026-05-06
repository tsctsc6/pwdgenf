use crate::clean_error::CleanError;
use crate::entities::acct_data;
use crate::factory::create_db_connection;
use anyhow::{anyhow, Context};
use flutter_rust_bridge::frb;
use sea_orm::EntityTrait;

#[frb]
pub async fn delete_acct_data(app_support_directory: String, id: i32) -> Result<(), CleanError> {
    let db = create_db_connection(&app_support_directory).await?;
    let result = acct_data::Entity::delete_by_id(id)
        .exec(&db)
        .await
        .context("Failed to delete account data")?;
    if result.rows_affected == 0 {
        Err(anyhow!("0 row affected".to_string(),))?
    }
    Ok(())
}
