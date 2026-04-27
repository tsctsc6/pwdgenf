use tracing::debug;

use crate::logger::init_logger;

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
    match init_logger(3) {
        Ok(()) => debug!("init_app called"),
        Err(e) => eprintln!("Failed to initialize logger: {e}"),
    }
}
