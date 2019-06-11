defmodule ExtensionsHelloWorld.Infrastructure.RGBColorPickerTest do
  use ExUnit.Case, async: true

  alias ExtensionsHelloWorld.Infrastructure.RGBColorPicker

  describe "pick" do
    test "will return an hex color code between #FF0000 #00FF00 and #0000FF" do
      color = RGBColorPicker.pick()

      assert Regex.match?(~r/#FF0000|#00FF00|#0000FF/, color)
    end
  end
end