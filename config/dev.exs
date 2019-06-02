use Mix.Config

config :extensions_hello_world,
  token_authenticator: ExtensionsHelloWorld.JWTTokenAuthenticator,
  change_color_use_case: ExtensionsHelloWorld.UseCases.ChangeColor,
  users: ExtensionsHelloWorld.Infrastructure.GenServerUsers,
  channels: ExtensionsHelloWorld.Infrastructure.GenServerChannels,
  color_picker: ExtensionsHelloWorld.Infrastructure.RGBColorPicker,
  cooldown: ExtensionsHelloWorld.Infrastructure.ThirtySecondsCoolDown,
  publisher: ExtensionsHelloWorld.Infrastructure.TwitchAPIPublisher

config :extensions_hello_world,
  jwt_token_authenticator_secret: "" # Use the JWT_TOKEN_AUTHENTICATOR_SECRET env variable
