defmodule ExtensionsHelloWorld.ChangeColorUseCaseTest do
  use ExUnit.Case, async: true

  import Mox

  alias ExtensionsHelloWorld.User
  alias ExtensionsHelloWorld.MockUsers, as: Users
  alias ExtensionsHelloWorld.MockCoolDown, as: CoolDown

  alias ExtensionsHelloWorld.Channel
  alias ExtensionsHelloWorld.MockChannels, as: Channels
  alias ExtensionsHelloWorld.MockColorPicker, as: ColorPicker

  alias ExtensionsHelloWorld.UseCases.ChangeColor

  setup :verify_on_exit!

  describe "when user is in cool down" do
    test "it will return an error" do
      expect(Users, :find, fn("A USER ID") ->
        %User{
          id: "A USER ID",
          cooldown: date_time_add(30, :seconds)
        }
      end)

      response = ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")

      assert response == {:error, "user is in cool down"}
    end
  end

  describe "when user is not in cool down" do
    setup do
      expect(Users, :find, fn("A USER ID") ->
        %User{
          id: "A USER ID",
          cooldown: date_time_subtract(30, :seconds)
        }
      end)

      stub(CoolDown, :new, fn() -> nil end)
      stub(Users, :save, fn(_) -> :ok end)
      stub(ColorPicker, :pick, fn() -> nil end)
      stub(Channels, :save, fn(_) -> :ok end)

      :ok
    end

    test "it will return a successful response" do
      response = ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")

      assert response == {:ok, "user is changing color"}
    end

    test "it will set the new cool down" do
      expected_new_cooldown = date_time_add(30, :seconds)

      expected_user = %User{
        id: "A USER ID",
        cooldown: expected_new_cooldown
      }

      expect(CoolDown, :new, fn() -> expected_new_cooldown end)
      expect(Users, :save, fn(^expected_user) -> :ok end)

      ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")
    end

    test "it will change the color to the channel" do
      expected_new_color = "A NEW COLOR"

      expected_channel = %Channel{
        id: "A CHANNEL ID",
        color: expected_new_color
      }

      expect(ColorPicker, :pick, fn() -> expected_new_color end)
      expect(Channels, :save, fn(^expected_channel) -> :ok end)

      ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")
    end

    test "it will send a notification about the color change" do
      ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")
    end
  end

  defp date_time_add(seconds_to_add, :seconds) do
    now() |> DateTime.add(seconds_to_add, :second)
  end

  defp date_time_subtract(seconds_to_subtract, :seconds) do
    now() |> DateTime.add(-seconds_to_subtract, :second)
  end

  defp now() do
    {:ok, datetime} = DateTime.now("Etc/UTC")
    datetime
  end
end