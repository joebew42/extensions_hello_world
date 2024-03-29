defmodule ExtensionsHelloWorld.Infrastructure.JWTTokenAuthenticator do
  @behaviour ExtensionsHelloWorld.Model.TokenAuthenticator

  @impl true
  def validate(token) do
    case Joken.verify(token, hs256_signer()) do
      {:error, :signature_error} ->
        {:error, :not_valid}

      {:ok, %{"channel_id" => channel_id, "opaque_user_id" => user_id}} ->
        {:ok,
         %{
           "channel_id" => channel_id,
           "user_id" => user_id
         }}
    end
  end

  defp hs256_signer() do
    Joken.Signer.create("HS256", Base.decode64!(secret()))
  end

  defp secret() do
    Application.get_env(:extensions_hello_world, :jwt_token_authenticator_secret) ||
      System.get_env("JWT_TOKEN_AUTHENTICATOR_SECRET")
  end
end
