defmodule ExtensionsHelloWorldTest do
  use ExUnit.Case
  doctest ExtensionsHelloWorld

  test "greets the world" do
    assert ExtensionsHelloWorld.hello() == :world
  end
end
