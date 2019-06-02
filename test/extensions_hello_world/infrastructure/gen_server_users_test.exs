defmodule ExtensionsHelloWorld.Infrastructure.GenServerUsersTest do
  use ExUnit.Case, async: true

  alias ExtensionsHelloWorld.Model.User
  alias ExtensionsHelloWorld.Infrastructure.GenServerUsers, as: Users

  setup do
    start_supervised(Users)
    :ok
  end

  describe "find" do
    test "return not found when the user not exist" do
      assert Users.find("A USER ID") == {:error, :not_found}
    end

    test "return the user" do
      user = %User{
        id: "AN ID",
        cooldown: nil
      }

      Users.save(user)

      assert Users.find(user.id) == user
    end
  end

  describe "save" do
    test "return ok when a user is saved" do
      user = %User{
        id: "AN ID",
        cooldown: nil
      }

      assert Users.save(user) == :ok
    end
  end
end