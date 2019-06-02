defmodule ExtensionsHelloWorld.Infrastructure.ThirtySecondsCoolDown do
  @behaviour ExtensionsHelloWorld.Model.CoolDown

  @impl true
  def new() do
    {:ok, now} = DateTime.now("Etc/UTC")

    DateTime.add(now, 30, :second)
  end
end
