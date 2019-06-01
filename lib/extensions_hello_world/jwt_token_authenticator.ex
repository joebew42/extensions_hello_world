defmodule ExtensionsHelloWorld.JWTTokenAuthenticator do
  @behaviour ExtensionsHelloWorld.TokenAuthenticator

  @impl true
  def validate(token) do
    case Joken.verify_and_validate(%{}, token, hs256_signer()) do
      {:error, :signature_error} ->
        {:error, :not_valid}

      {:ok, payload} ->
        {:ok, payload}
    end
  end

  defp hs256_signer() do
    Joken.Signer.create("HS256", secret())
  end

  defp secret() do
    System.get_env("JWT_TOKEN_AUTHENTICATOR_SECRET") ||
      Application.get_env(:extensions_hello_world, :jwt_token_authenticator_secret)
  end
end