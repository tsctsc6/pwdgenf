use sea_orm_migration::{prelude::*, schema::*};

// #[derive(DeriveMigrationName)]
pub struct Migration;

// Manually specify the migration name, because it is different in desktop and android.
impl MigrationName for Migration {
    fn name(&self) -> &str {
        "m20260427_000001_create_table"
    }
}

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                Table::create()
                    .table("AcctData")
                    .if_not_exists()
                    .col(pk_auto("Id"))
                    .col(string("UserName"))
                    .col(string("Platform"))
                    .col(string("Remark"))
                    .col(integer("NonceOffset"))
                    .col(boolean("UseUpLetter"))
                    .col(boolean("UseLowLetter"))
                    .col(boolean("UseNumber"))
                    .col(boolean("UseSpChar"))
                    .col(integer("PwdLen"))
                    .col(string("UpdatedAt"))
                    .to_owned(),
            )
            .await
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table("AcctData").to_owned())
            .await
    }
}
