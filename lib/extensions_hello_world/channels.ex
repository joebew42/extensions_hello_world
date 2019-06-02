defmodule ExtensionsHelloWorld.Channels do
  alias ExtensionsHelloWorld.Channel

  @callback save(%Channel{}) :: :ok
end