defmodule ExtensionsHelloWorld.ChangeColorUseCaseTest do
  use ExUnit.Case, async: true

  alias ExtensionsHelloWorld.ChangeColorUseCase, as: ChangeColor

  describe "when the user is in cool down" do
    test "return an error" do
      response = ChangeColor.run_with(channel_id: "A CHANNEL ID", user_id: "A USER ID")

      assert response == {:error, "user is in cool down"}
    end
  end
end