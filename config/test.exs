use Mix.Config

config :plug, :validate_header_keys_during_test, true

config :extensions_hello_world,
  token_authenticator: ExtensionsHelloWorld.MockTokenAuthenticator,
  change_color_use_case: ExtensionsHelloWorld.MockUseCase,
  users: ExtensionsHelloWorld.MockUsers,
  channels: ExtensionsHelloWorld.MockChannels,
  color_picker: ExtensionsHelloWorld.MockColorPicker,
  cooldown: ExtensionsHelloWorld.MockCoolDown,
  publisher: ExtensionsHelloWorld.MockPublisher

config :extensions_hello_world,
  # "secret"
  jwt_token_authenticator_secret: "c2VjcmV0"
