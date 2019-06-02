defmodule ExtensionsHelloWorld.Infrastructure.GenServerUsers do
  @behaviour ExtensionsHelloWorld.Model.Users

  alias ExtensionsHelloWorld.Model.User

  @impl true
  def find(user_id) do
    GenServer.call(__MODULE__, {:find, user_id})
  end

  @impl true
  def save(%User{} = user) do
    :ok = GenServer.call(__MODULE__, {:save, user})
  end

  # # # # # # # # # # # # # # # #
  #   GenServer Implementation  #
  # # # # # # # # # # # # # # # #

  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:save, %User{} = user}, _from, state) do
    new_state = Map.put(state, user.id, user)

    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call({:find, user_id}, _from, state) do
    response =
      case Map.get(state, user_id) do
        nil ->
          {:error, :not_found}

        user ->
          user
      end

    {:reply, response, state}
  end
end
