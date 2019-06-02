defmodule ExtensionsHelloWorld.Model.User do
  defstruct id: nil, cooldown: nil

  def cooldown?(%__MODULE__{cooldown: nil}) do
    false
  end

  def cooldown?(%__MODULE__{cooldown: cooldown}) do
    {:ok, now} = DateTime.now("Etc/UTC")

    case DateTime.compare(now, cooldown) do
      :lt ->
        true

      _ ->
        false
    end
  end

  def set_cooldown(%__MODULE__{} = user, new_cooldown) do
    %__MODULE__{user | cooldown: new_cooldown}
  end
end
