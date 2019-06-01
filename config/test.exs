use Mix.Config

config :plug, :validate_header_keys_during_test, true

config :extensions_hello_world,
  token_authenticator: ExtensionsHelloWorld.MockTokenAuthenticator,
  change_color_use_case: ExtensionsHelloWorld.MockUseCase

config :extensions_hello_world,
  jwt_token_authenticator_secret: "A SECRET"
