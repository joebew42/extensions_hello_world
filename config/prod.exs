use Mix.Config

config :extensions_hello_world,
  token_authenticator: ExtensionsHelloWorld.Infrastructure.JWTTokenAuthenticator,
  change_color_use_case: ExtensionsHelloWorld.UseCases.ChangeColor

config :extensions_hello_world,
  # Use the JWT_TOKEN_AUTHENTICATOR_SECRET env variable
  jwt_token_authenticator_secret: nil,
  # Use the TWITCH_API_PUBLISHER_CLIENT_ID env variable
  twitch_api_publisher_client_id: nil,
  # Use the TWITCH_API_PUBLISHER_OWNER_ID
  twitch_api_publisher_owner_id: nil
