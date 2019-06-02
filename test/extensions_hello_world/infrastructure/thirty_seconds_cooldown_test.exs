defmodule ExtensionsHelloWorld.Infrastructure.ThirtySecondsCoolDownTest do
  use ExUnit.Case, async: true

  alias ExtensionsHelloWorld.Infrastructure.ThirtySecondsCoolDown, as: CoolDown

  describe "new" do
    test "will return a date time with 30 seconds more from now" do
      {:ok, now} = DateTime.now("Etc/UTC")

      cooldown = CoolDown.new()

      assert diff_in_seconds(now, cooldown) == 30
    end
  end

  defp diff_in_seconds(datetime1, datetime2) do
    DateTime.to_unix(datetime2) - DateTime.to_unix(datetime1)
  end
end