defmodule ExtensionsHelloWorld.UseCases.ChangeColor do
  @behaviour ExtensionsHelloWorld.UseCase

  alias ExtensionsHelloWorld.User
  alias ExtensionsHelloWorld.MockUsers, as: Users

  @impl true
  def run_with(channel_id: _channel_id, user_id: user_id) do
    user = Users.find(user_id)

    case User.cooldown?(user) do
      true ->
        {:error, "user is in cool down"}
      false ->
        {:ok, "user is changing color"}
    end
  end
end