defmodule ExtensionsHelloWorld.Model.ColorPicker do
  @type color :: String.t()

  @callback pick() :: color()
end