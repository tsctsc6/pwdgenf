use crate::factory::create_db_connection;
use crate::{clean_error::CleanError, entities::acct_data};
use anyhow::{anyhow, Context};
use chrono::Utc;
use flutter_rust_bridge::frb;
use sea_orm::{ActiveModelTrait, EntityTrait, IntoActiveModel, Set};

pub struct UpdateAcctDataRequest {
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
}

fn validate(request: &UpdateAcctDataRequest) -> Result<(), CleanError> {
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

    Ok(())
}

#[frb]
pub async fn update_acct_data(
    app_support_directory: String,
    request: UpdateAcctDataRequest,
) -> Result<(), CleanError> {
    validate(&request)?;
    let db = create_db_connection(&app_support_directory).await?;
    let acct_data_to_update = acct_data::Entity::find_by_id(request.id)
        .one(&db)
        .await
        .context("Failed to read account data")?;
    let acct_data_to_update = match acct_data_to_update {
        None => Err(anyhow!("The item which id = {} not found", request.id))?,
        Some(x) => x,
    };
    let mut acct_data_to_update = acct_data_to_update.into_active_model();
    acct_data_to_update.user_name = Set((&request).user_name.clone());
    acct_data_to_update.platform = Set((&request).platform.clone());
    acct_data_to_update.remark = Set((&request).remark.clone());
    acct_data_to_update.nonce_offset = Set((&request).nonce_offset.clone());
    acct_data_to_update.use_up_letter = Set((&request).use_up_letter.clone());
    acct_data_to_update.use_low_letter = Set((&request).use_low_letter.clone());
    acct_data_to_update.use_number = Set((&request).use_number.clone());
    acct_data_to_update.use_sp_char = Set((&request).use_sp_char.clone());
    acct_data_to_update.pwd_len = Set((&request).pwd_len.clone());
    acct_data_to_update.updated_at =
        Set(Utc::now().to_rfc3339_opts(chrono::SecondsFormat::Millis, false));
    acct_data_to_update
        .update(&db)
        .await
        .context("Failed to update account data")?;
    Ok(())
}
