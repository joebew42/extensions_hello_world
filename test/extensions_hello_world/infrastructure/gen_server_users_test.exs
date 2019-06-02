defmodule ExtensionsHelloWorld.Infrastructure.GenServerUsersTest do
  use ExUnit.Case, async: true

  alias ExtensionsHelloWorld.Infrastructure.GenServerUsers, as: Users

  describe "find" do
    test "return not found when the user not exist" do
      assert Users.find("A USER ID") == {:error, :not_found}
    end
  end
end