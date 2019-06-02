defmodule ExtensionsHelloWorld.Model.Users do
  alias ExtensionsHelloWorld.Model.User

  @type user_id :: String.t()

  @callback find(user_id()) :: %User{} | {:error, :not_found}
  @callback save(%User{}) :: :ok
end