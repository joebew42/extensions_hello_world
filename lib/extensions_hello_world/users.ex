defmodule ExtensionsHelloWorld.Users do
  alias ExtensionsHelloWorld.User

  @type user_id :: String.t()

  @callback find(user_id()) :: {:ok, %User{}} | {:error, :not_found}
  @callback save(%User{}) :: :ok
end