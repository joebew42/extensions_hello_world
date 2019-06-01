defmodule ExtensionsHelloWorld.Web.Controller do
  use Plug.Router

  plug :match
  plug :dispatch

  post "/color/cycle" do
    case token_authenticator().validate(token_from(conn)) do
      {:error, :not_valid} ->
        send_resp(conn, 401, "")

      {:ok, payload} ->
        case change_color().run_with(channel_id: payload["channel_id"], user_id: payload["user_id"]) do
          {:error, "user is in cool down"} ->
            send_resp(conn, 429, "User is in cool down")
          {:ok, "user is changing color"} ->
            send_resp(conn, 202, "")
        end
    end
  end

  defp token_from(conn) do
    conn
    |> get_req_header("authorization")
    |> extract_bearer_token()
  end

  defp extract_bearer_token([full_with_bearer]) do
    bearer = byte_size("Bearer ")
    binary_part(full_with_bearer, bearer, byte_size(full_with_bearer) - bearer)
  end

  defp token_authenticator() do
    Application.get_env(:extensions_hello_world, :token_authenticator)
  end

  defp change_color() do
    Application.get_env(:extensions_hello_world, :change_color_use_case)
  end
end