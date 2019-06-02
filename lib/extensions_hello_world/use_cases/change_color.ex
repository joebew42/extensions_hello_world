defmodule ExtensionsHelloWorld.UseCases.ChangeColor do
  @behaviour ExtensionsHelloWorld.UseCase

  @user_is_in_cool_down   "user is in cool down"
  @user_is_changing_color "user is changing color"

  alias ExtensionsHelloWorld.User
  alias ExtensionsHelloWorld.MockUsers, as: Users
  alias ExtensionsHelloWorld.MockCoolDown, as: CoolDown

  @impl true
  def run_with(channel_id: _channel_id, user_id: user_id) do
    user = Users.find(user_id)

    case User.cooldown?(user) do
      true ->
        {:error, @user_is_in_cool_down}
      false ->
        :ok =
          user
          |> User.set_cooldown(CoolDown.new())
          |> Users.save()

        {:ok, @user_is_changing_color}
    end
  end
end