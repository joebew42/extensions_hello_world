defmodule ExtensionsHelloWorld.ChangeColorUseCaseTest do
  use ExUnit.Case, async: true

  alias ExtensionsHelloWorld.ChangeColorUseCase, as: ChangeColor

  describe "when the user is in cool down" do
    test "it will return an error" do
      response = ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A COOL DOWN USER ID")

      assert response == {:error, "user is in cool down"}
    end
  end

  describe "when the user is not in cool down" do
    test "it will change the color, set a new cool down and notify the change" do
      response = ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")

      assert response == {:ok, "user is changing color"}
    end
  end
end