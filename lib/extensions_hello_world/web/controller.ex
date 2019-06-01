defmodule ExtensionHelloWorld.Web.Controller do
  use Plug.Router

  plug :match
  plug :dispatch

  post "/color/cycle" do
    send_resp(conn, 401, "")
  end
end