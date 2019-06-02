defmodule ExtensionsHelloWorld.Infrastructure.TwitchAPIPublisher do
  @behaviour ExtensionsHelloWorld.Model.Publisher

  @token_expire 30

  @impl true
  def publish(%{channel_id: channel_id, color: color}) do
    headers = [
      "Client-ID": client_id(),
      "Content-Type": "application/json",
      Authorization: "Bearer #{to_jwt(channel_id)}"
    ]

    body =
      Jason.encode!(%{
        content_type: "application/json",
        message: color,
        targets: ["broadcast"]
      })

    %HTTPoison.Response{status_code: 204} =
      HTTPoison.post!("https://api.twitch.tv/extensions/message/#{channel_id}", body, headers)
      |> IO.inspect(label: "response from Twitch API")

    :ok
  end

  defp to_jwt(channel_id) do
    payload = %{
      exp: time_in_seconds() + @token_expire,
      channel_id: channel_id,
      user_id: owner_id(),
      role: "external",
      pubsub_perms: %{
        send: ["*"]
      }
    }

    encode_and_sign(payload)
  end

  defp encode_and_sign(payload) do
    signer = Joken.Signer.create("HS256", Base.decode64!(secret()))

    {:ok, token, _} = Joken.encode_and_sign(payload, signer)

    token
  end

  defp time_in_seconds() do
    {:ok, datetime} = DateTime.now("Etc/UTC")
    DateTime.to_unix(datetime)
  end

  defp client_id() do
    System.get_env("TWITCH_API_PUBLISHER_CLIENT_ID")
  end

  defp owner_id() do
    System.get_env("TWITCH_API_PUBLISHER_OWNER_ID")
  end

  defp secret() do
    System.get_env("JWT_TOKEN_AUTHENTICATOR_SECRET")
  end
end
