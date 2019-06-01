defmodule ExtensionsHelloWorld.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: ExtensionsHelloWorld.Web.Controller, options: [port: 4001])
    ]

    opts = [strategy: :one_for_one, name: ExtensionsHelloWorld.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
