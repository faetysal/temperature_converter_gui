//! This `hub` crate is the
//! entry point of the Rust logic.

mod common;
mod messages;

use crate::common::*;
use tokio; // Comment this line to target the web.
// use tokio_with_wasm::alias as tokio; // Uncomment this line to target the web.

rinf::write_interface!();

// Use `tokio::spawn` to run concurrent tasks.
// Always use non-blocking async functions
// such as `tokio::fs::File::open`.
// If you really need to use blocking code,
// use `tokio::task::spawn_blocking`.
async fn main() {
    tokio::spawn(convert());
}

async fn convert() -> Result<()> {
    use messages::temperature::*;

    let mut receiver = InputTemperature::get_dart_signal_receiver()?;
    if let Some(dart_signal) = receiver.recv().await {
      let data = dart_signal.message;

      rinf::debug_print!("Input temperature: {:?}", data);
    }

    
    Ok(())
}
