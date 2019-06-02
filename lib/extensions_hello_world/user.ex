defmodule ExtensionsHelloWorld.User do
  defstruct id: nil, cooldown: nil

  def cooldown?(%__MODULE__{ cooldown: cooldown }) do
    {:ok, now} = DateTime.now("Etc/UTC")

    case DateTime.compare(now, cooldown) do
      :lt ->
        true
      _ ->
        false
    end
  end
end