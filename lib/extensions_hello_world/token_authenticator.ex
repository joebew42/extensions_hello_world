defmodule ExtensionHelloWorld.TokenAuthenticator do
  @type token :: String.t()

  @type response :: {:ok, map()} | {:error, :token_not_valid}

  @callback validate(token()) :: response()
end