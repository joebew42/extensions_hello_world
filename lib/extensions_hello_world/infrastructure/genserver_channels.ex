defmodule ExtensionsHelloWorld.Infrastructure.GenServerChannels do
  @behaviour ExtensionsHelloWorld.Model.Channels

  @impl true
  def save(_channel) do
    :ok
  end
end
