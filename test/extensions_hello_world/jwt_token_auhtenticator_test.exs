defmodule ExtensionHelloWorld.JWTTokenAuthenticatorTest do
  use ExUnit.Case, async: true

  alias ExtensionHelloWorld.JWTTokenAuthenticator, as: TokenAuthenticator

  describe "#validate" do
    test "return error when the token is not valid" do
      assert TokenAuthenticator.validate("NOT VALID") == {:error, :not_valid}
    end

    test "return the information contained in token when it is valid" do
      token = build_token_for(%{"KEY" => "VALUE"})

      assert TokenAuthenticator.validate(token) == {:ok, %{"KEY" => "VALUE"}}
    end
  end

  defp build_token_for(payload) do
    secret = Application.get_env(:extension_hello_world, :jwt_token_authenticator_secret)
    signer = Joken.Signer.create("HS256", secret)

    {:ok, token, _} = Joken.encode_and_sign(payload, signer)

    token
  end
end