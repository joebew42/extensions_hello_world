defmodule ExtensionHelloWorld.FakeTokenAuthenticator do
  @behaviour ExtensionHelloWorld.TokenAuthenticator

  @impl true
  def validate(token) do
    case token do
      "invalid token" ->
        {:error, :token_not_valid}

      "valid token" ->
        {:ok, %{ "channel_id" => "A CHANNEL ID", "user_id" => "A USER ID" }}
    end
  end
end