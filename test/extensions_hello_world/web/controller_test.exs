defmodule ExtensionsHelloWorld.Web.ControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Mox

  alias ExtensionsHelloWorld.MockTokenAuthenticator, as: TokenAuthenticator
  alias ExtensionsHelloWorld.MockUseCase, as: ChangeColor

  alias ExtensionsHelloWorld.Web.Controller

  @opts Controller.init([])

  setup :verify_on_exit!

  describe "with an invalid token" do
    test "POST /color/cycle returns a 401 Unauthorized" do
      expect(TokenAuthenticator, :validate, fn(_) -> {:error, :not_valid} end)

      conn =
        post("/color/cycle")
        |> with_authorization("Bearer invalid token")
        |> call(Controller)

      assert conn.status == 401
      assert conn.resp_body == ""
    end
  end

  describe "with a valid token" do
    test "POST /color/cycle returns a 429 Too Many Requests when user is in cool down" do
      expect(TokenAuthenticator, :validate, fn("A VALID TOKEN") ->
        {:ok, %{ "channel_id" => "A CHANNEL ID", "user_id" => "A USER ID" }}
      end)
      expect(ChangeColor, :run_with, fn(channel_id: "A CHANNEL ID", user_id: "A USER ID") ->
        {:error, "user is in cool down"}
      end)

      conn =
        post("/color/cycle")
        |> with_authorization("Bearer A VALID TOKEN")
        |> call(Controller)

      assert conn.status == 429
      assert conn.resp_body == "User is in cool down"
    end

    test "POST /color/cycle returns a 202 Accepted when a user is changing color" do
      expect(TokenAuthenticator, :validate, fn("A VALID TOKEN") ->
        {:ok, %{ "channel_id" => "A CHANNEL ID", "user_id" => "A USER ID" }}
      end)
      expect(ChangeColor, :run_with, fn(channel_id: "A CHANNEL ID", user_id: "A USER ID") ->
        {:ok, "user is changing color"}
      end)

      conn =
        post("/color/cycle")
        |> with_authorization("Bearer A VALID TOKEN")
        |> call(Controller)

      assert conn.status == 202
      assert conn.resp_body == ""
    end
  end

  defp post(endpoint) do
    conn(:post, endpoint)
  end

  defp with_authorization(conn, authorization) do
    put_req_header(conn, "authorization", authorization)
  end

  defp call(conn, plug_router) do
    plug_router.call(conn, @opts)
  end
end