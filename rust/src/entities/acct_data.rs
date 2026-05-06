use sea_orm::entity::prelude::*;

#[sea_orm::model]
#[derive(Clone, Debug, PartialEq, Eq, DeriveEntityModel)]
#[sea_orm(table_name = "AcctData", rename_all = "PascalCase")]
pub struct Model {
    #[sea_orm(primary_key)]
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

impl ActiveModelBehavior for ActiveModel {}
