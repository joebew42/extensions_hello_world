defmodule ExtensionsHelloWorld.Infrastructure.TwitchAPIPublisherTest do
  use ExUnit.Case, async: true

  alias ExtensionsHelloWorld.Infrastructure.TwitchAPIPublisher, as: Publisher

  setup do
    Application.ensure_all_started(:httpoison)
    :ok
  end

  @tag :integration
  describe "publish" do
    test "will send a notification using Twitch API" do
      channel_id = System.get_env("TWITCH_API_PUBLISHER_CHANNEL_ID")
      refute channel_id == nil, "You need to set TWITCH_API_PUBLISHER_CHANNEL_ID env variable. Check the README.md"

      notification = %{
        channel_id: channel_id,
        color: "#000000"
      }

      :ok = Publisher.publish(notification)
    end
  end
end