defmodule ExtensionsHelloWorld.JWTTokenAuthenticatorTest do
  use ExUnit.Case, async: true

  alias ExtensionsHelloWorld.JWTTokenAuthenticator, as: TokenAuthenticator

  describe "#validate" do
    test "return error when the token is not valid" do
      assert TokenAuthenticator.validate("NOT VALID") == {:error, :not_valid}
    end

    test "return the information contained in token when it is valid" do
      # Twitch Extension JWT Schema
      # https://dev.twitch.tv/docs/extensions/reference/#jwt-schema
      token = build_token_for(%{
        "exp" => 1484242525,
        "opaque_user_id" => "UG12X345T6J78",
        "channel_id" => "test_channel",
        "role" => "broadcaster",
        "is_unlinked" => "false",
        "pubsub_perms" => %{
          "listen" => ["broadcast", "whisper-UG12X345T6J78"],
          "send" => ["broadcast","whisper-*"]
        }
      })

      assert TokenAuthenticator.validate(token) == {:ok, %{
        "channel_id" => "test_channel",
        "user_id" => "UG12X345T6J78"
      }}
    end
  end

  defp build_token_for(payload) do
    secret = Application.get_env(:extensions_hello_world, :jwt_token_authenticator_secret)
    signer = Joken.Signer.create("HS256", secret)

    {:ok, token, _} = Joken.encode_and_sign(payload, signer)

    token
  end
end