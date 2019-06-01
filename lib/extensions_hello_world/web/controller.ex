defmodule ExtensionHelloWorld.Web.Controller do
  use Plug.Router

  plug :match
  plug :dispatch

  alias ExtensionHelloWorld.MockTokenAuthenticator, as: TokenAuthenticator
  alias ExtensionHelloWorld.MockUseCase, as: ChangeColor

  post "/color/cycle" do
    case TokenAuthenticator.validate(token_from(conn)) do
      {:error, :not_valid} ->
        send_resp(conn, 401, "")

      {:ok, payload} ->
        case ChangeColor.run_with(channel_id: payload["channel_id"], user_id: payload["user_id"]) do
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
end