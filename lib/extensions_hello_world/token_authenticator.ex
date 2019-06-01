defmodule ExtensionsHelloWorld.TokenAuthenticator do
  @type token :: String.t()

  @type response :: {:ok, map()} | {:error, :not_valid}

  @callback validate(token()) :: response()
end