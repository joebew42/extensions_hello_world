defmodule ExtensionHelloWorld.Web.Controller do
  use Plug.Router

  plug :match
  plug :dispatch

  post "/color/cycle" do
    case get_req_header(conn, "authorization") do
      ["Bearer invalid token"] ->
        send_resp(conn, 401, "")

      ["Bearer valid token"] ->
        send_resp(conn, 429, "User is in cool down")

      ["Bearer valid token accepted"] ->
          send_resp(conn, 202, "")
    end
  end
end