defmodule ExtensionHelloWorld.Web.ControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ExtensionHelloWorld.Web.Controller

  @opts Controller.init([])

  describe "with an invalid token" do
    test "POST /color/cycle returns a 401 Unauthorized" do
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
      conn =
        post("/color/cycle")
        |> with_authorization("Bearer valid token")
        |> call(Controller)

        assert conn.status == 429
        assert conn.resp_body == "User is in cool down"
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