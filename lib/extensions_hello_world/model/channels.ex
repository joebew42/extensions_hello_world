defmodule ExtensionsHelloWorld.Model.Channels do
  alias ExtensionsHelloWorld.Model.Channel

  @callback save(%Channel{}) :: :ok
end
