defmodule ExtensionsHelloWorld.ColorPicker do
  @type color :: String.t()

  @callback pick() :: color()
end