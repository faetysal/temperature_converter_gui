//! This `hub` crate is the
//! entry point of the Rust logic.

mod common;
mod messages;
mod temperature;

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
    while let Some(dart_signal) = receiver.recv().await {
      let data = dart_signal.message;

      rinf::debug_print!("Input temperature message: {:?}", data);

      let input_temperature = temperature::Temperature::new(
        data.value,
        &data.input_unit
      );
      let output_temperature = input_temperature.to(&data.output_unit);

      rinf::debug_print!("Output temperatuure: {:?}", output_temperature);

      OutputTemperature { 
        value: output_temperature.value.to_string(),
        output_unit: output_temperature.scale.kind.unit()
      }.send_signal_to_dart();
    }

    
    Ok(())
}
