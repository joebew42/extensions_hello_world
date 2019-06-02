defmodule ExtensionsHelloWorld.Infrastructure.GenServerUsers do
  @behaviour ExtensionsHelloWorld.Users

  @impl true
  def find(_user_id) do
    raise "Not Yet Implemented"
  end

  @impl true
  def save(_user) do
    raise "Not Yet Implemented"
  end
end