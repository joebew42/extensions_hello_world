defmodule ExtensionsHelloWorld.ChangeColorUseCase do
  @behaviour ExtensionsHelloWorld.UseCase

  @impl true
  def run_with(channel_id: _channel_id, user_id: _user_id) do
    {:error, "user is in cool down"}
  end
end