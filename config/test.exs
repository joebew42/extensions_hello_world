use Mix.Config

config :plug, :validate_header_keys_during_test, true

config :extension_hello_world,
 :jwt_token_authenticator_secret, "A SECRET"
