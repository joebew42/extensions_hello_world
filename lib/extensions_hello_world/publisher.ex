defmodule ExtensionsHelloWorld.Publisher do
  @type notification :: map()

  @callback publish(notification()) :: :ok
end