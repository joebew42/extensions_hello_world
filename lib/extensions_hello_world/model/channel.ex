defmodule ExtensionsHelloWorld.Model.Channel do
  defstruct id: nil, color: nil

  def set_color(%__MODULE__{} = channel, color) do
    %__MODULE__{channel | color: color}
  end
end