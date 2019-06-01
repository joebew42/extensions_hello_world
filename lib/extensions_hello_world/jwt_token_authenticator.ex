defmodule ExtensionHelloWorld.JWTTokenAuthenticator do
  @behaviour ExtensionHelloWorld.TokenAuthenticator

  @impl true
  def validate(token) do
    case Joken.verify_and_validate(%{}, token, h256_signer()) do
      {:error, :signature_error} ->
        {:error, :not_valid}

      {:ok, payload} ->
        {:ok, payload}
    end
  end

  defp h256_signer() do
    secret = Application.get_env(:extensions_hello_world, :jwt_token_authenticator_secret)
    Joken.Signer.create("HS256", secret)
  end
end