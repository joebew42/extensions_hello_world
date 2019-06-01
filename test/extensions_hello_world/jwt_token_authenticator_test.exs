defmodule ExtensionsHelloWorld.JWTTokenAuthenticatorTest do
  use ExUnit.Case, async: true

  alias ExtensionsHelloWorld.JWTTokenAuthenticator, as: TokenAuthenticator

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
    signer = Joken.Signer.create("HS256", secret())

    {:ok, token, _} = Joken.encode_and_sign(payload, signer)

    token
  end

  defp secret() do
    System.get_env("JWT_TOKEN_AUTHENTICATOR_SECRET") ||
      Application.get_env(:extensions_hello_world, :jwt_token_authenticator_secret)
  end
end