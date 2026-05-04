use crate::factory::create_db_connection;
use crate::{clean_error::CleanError, entities::acct_data};
use anyhow::{anyhow, Context};
use chrono::Utc;
use flutter_rust_bridge::frb;
use sea_orm::{ActiveModelTrait, ActiveValue};

pub struct CreateAcctDataRequest {
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

pub fn validate(request: &CreateAcctDataRequest) -> Result<(), CleanError> {
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
pub async fn create_acct_data(
    app_support_directory: String,
    request: CreateAcctDataRequest,
) -> Result<(), CleanError> {
    validate(&request)?;
    let db = create_db_connection(&app_support_directory).await?;
    let acct_data_to_create = acct_data::ActiveModel {
        user_name: ActiveValue::Set(request.user_name),
        platform: ActiveValue::Set(request.platform),
        remark: ActiveValue::Set(request.remark),
        nonce_offset: ActiveValue::Set(request.nonce_offset),
        use_up_letter: ActiveValue::Set(request.use_up_letter),
        use_low_letter: ActiveValue::Set(request.use_low_letter),
        use_number: ActiveValue::Set(request.use_number),
        use_sp_char: ActiveValue::Set(request.use_sp_char),
        pwd_len: ActiveValue::Set(request.pwd_len),
        updated_at: ActiveValue::Set(
            Utc::now().to_rfc3339_opts(chrono::SecondsFormat::Millis, false),
        ),
        ..Default::default()
    };
    acct_data_to_create
        .insert(&db)
        .await
        .context("Failed to add account data")?;
    Ok(())
}
