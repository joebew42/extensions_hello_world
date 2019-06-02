defmodule ExtensionsHelloWorld.Application do
  use Application

  alias ExtensionsHelloWorld.Infrastructure.WebController
  alias ExtensionsHelloWorld.Infrastructure.GenServerUsers

  def start(_type, _args) do
    children = [
      GenServerUsers,
      Plug.Cowboy.child_spec(scheme: :http, plug: WebController, options: [port: 4001])
    ]

    opts = [strategy: :one_for_one, name: ExtensionsHelloWorld.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
