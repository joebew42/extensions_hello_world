defmodule ExtensionsHelloWorld.Infrastructure.GenServerUsers do
  @behaviour ExtensionsHelloWorld.Model.Users

  alias ExtensionsHelloWorld.Model.User

  use GenServer

  @impl true
  def find(_user_id) do
    {:error, :not_found}
  end

  @impl true
  def save(%User{} = user) do
    :ok = GenServer.call(__MODULE__, {:save, user})
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:save, %User{} = user}, _from, state) do
    Map.put(state, user.id, user)

    {:reply, :ok, state}
  end
end