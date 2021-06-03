use ferrite_session::prelude::*;

type SayHi = SendValue<String, End>;

#[tokio::main]
async fn main() {
  pretty_env_logger::init();

  let provider: Session<SayHi> = send_value("Hello ferrite!".to_string(), terminate());

  let received_msg = run_session_with_result(provider).await;

  log::info!("{}", received_msg);
}
