use crate::factory::create_db_connection;
use crate::{clean_error::CleanError, entities::acct_data};
use anyhow::Context;
use flutter_rust_bridge::frb;
use migration::Condition;
use sea_orm::{
    ColumnTrait, DerivePartialModel, EntityTrait, Order, PaginatorTrait, QueryFilter, QueryOrder,
};
use serde::Serialize;

#[frb]
pub async fn read_all_acct_data(
    app_support_directory: String,
    search_term: String,
    page_index: u64,
    page_size: u64,
) -> Result<ReadAllAcctDataResult, CleanError> {
    let db = create_db_connection(&app_support_directory).await?;
    let acct_data_query = acct_data::Entity::find()
        .filter(
            Condition::any()
                .add(acct_data::Column::Platform.contains(&search_term))
                .add(acct_data::Column::UserName.contains(&search_term)),
        )
        .order_by(acct_data::Column::Id, Order::Asc)
        .into_partial_model()
        .paginate(&db, page_size);
    let acct_data_list = acct_data_query
        .fetch_page(page_index)
        .await
        .context("Failed to get account data list")?;
    let result = ReadAllAcctDataResult {
        total_count: acct_data_query
            .num_items()
            .await
            .context("Failed to get page count")?,
        page_content: acct_data_list,
    };
    Ok(result)
}

#[derive(DerivePartialModel, Serialize)]
#[sea_orm(entity = "acct_data::Entity")]
pub struct AcctDataPartialModel {
    pub id: i32,
    pub user_name: String,
    pub platform: String,
}

#[derive(Serialize)]
pub struct ReadAllAcctDataResult {
    pub total_count: u64,
    pub page_content: Vec<AcctDataPartialModel>,
}
