defmodule ExtensionsHelloWorld.ChangeColorUseCaseTest do
  use ExUnit.Case, async: true

  import Mox

  alias ExtensionsHelloWorld.MockUsers, as: Users
  alias ExtensionsHelloWorld.User
  alias ExtensionsHelloWorld.UseCases.ChangeColor

  setup :verify_on_exit!

  describe "when the user is in cool down" do
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

  describe "when the user is not in cool down" do
    setup do
      expect(Users, :find, fn("A USER ID") ->
        %User{
          id: "A USER ID",
          cooldown: date_time_subtract(30, :seconds)
        }
      end)

      :ok
    end

    test "it will set the new cool down" do
      response = ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")

      assert response == {:ok, "user is changing color"}
    end

    test "it will change the color" do
      response = ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")

      assert response == {:ok, "user is changing color"}
    end

    test "it will send a notification about the change" do
      response = ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")

      assert response == {:ok, "user is changing color"}
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