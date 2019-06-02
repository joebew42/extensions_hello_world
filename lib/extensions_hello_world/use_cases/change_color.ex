defmodule ExtensionsHelloWorld.UseCases.ChangeColor do
  @behaviour ExtensionsHelloWorld.UseCase

  alias ExtensionsHelloWorld.MockUsers, as: Users

  @impl true
  def run_with(channel_id: _channel_id, user_id: user_id) do

    user = Users.find(user_id)

    case user_id do
      "A COOL DOWN USER ID" ->
        {:error, "user is in cool down"}
      "A USER ID" ->
        {:ok, "user is changing color"}
    end
  end
end