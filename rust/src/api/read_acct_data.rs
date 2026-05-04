use crate::factory::create_db_connection;
use crate::{clean_error::CleanError, entities::acct_data};
use anyhow::Context;
use flutter_rust_bridge::frb;
use sea_orm::{DerivePartialModel, EntityTrait};

#[frb]
pub async fn read_acct_data(
    app_support_directory: String,
    id: i32,
) -> Result<ReadAcctDataResult, CleanError> {
    let db = create_db_connection(&app_support_directory).await?;
    let acct_data_to_read = acct_data::Entity::find_by_id(id)
        .into_partial_model()
        .one(&db)
        .await
        .context("Failed to read account data")?;
    let acct_data_to_read = match acct_data_to_read {
        None => Err(anyhow::anyhow!("The item which id = {} not found", id))?,
        Some(x) => x,
    };
    Ok(acct_data_to_read)
}

#[derive(DerivePartialModel)]
#[sea_orm(entity = "acct_data::Entity")]
pub struct ReadAcctDataResult {
    pub id: i32,
    pub user_name: String,
    pub platform: String,
    pub remark: String,
    pub nonce_offset: u32,
    pub use_up_letter: bool,
    pub use_low_letter: bool,
    pub use_number: bool,
    pub use_sp_char: bool,
    pub pwd_len: u32,
    pub updated_at: String,
}
