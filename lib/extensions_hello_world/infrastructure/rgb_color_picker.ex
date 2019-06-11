defmodule ExtensionsHelloWorld.Infrastructure.RGBColorPicker do
  @behaviour ExtensionsHelloWorld.Model.ColorPicker

  @colors %{
    1 => "#FF0000",
    2 => "#00FF00",
    3 => "#0000FF"
  }

  @impl true
  def pick() do
    Map.get(@colors, :rand.uniform(3))
  end
end
