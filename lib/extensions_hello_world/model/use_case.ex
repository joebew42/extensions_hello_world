defmodule ExtensionsHelloWorld.Model.UseCase do
  @type request :: keyword()

  @type response :: {:ok, String.t()} | {:error, String.t()}

  @callback run_with(request()) :: response()
end