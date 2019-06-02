defmodule ExtensionsHelloWorld.Application do
  use Application

  alias ExtensionsHelloWorld.Infrastructure.WebController

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: WebController, options: [port: 4001])
    ]

    opts = [strategy: :one_for_one, name: ExtensionsHelloWorld.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
