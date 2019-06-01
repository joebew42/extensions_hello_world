defmodule ExtensionHelloWorld.Web.Controller do
  use Plug.Router

  plug :match
  plug :dispatch

  alias ExtensionHelloWorld.MockUseCase, as: ChangeColor

  post "/color/cycle" do
    case get_req_header(conn, "authorization") do
      ["Bearer invalid token"] ->
        send_resp(conn, 401, "")

      ["Bearer valid token"] ->
        case ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID") do
          {:error, "user is in cool down"} ->
            send_resp(conn, 429, "User is in cool down")
          {:ok, "user is changing color"} ->
            send_resp(conn, 202, "")
        end
    end
  end
end