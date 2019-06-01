defmodule ExtensionsHelloWorld.Application do
  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: ExtensionsHelloWorld.Worker.start_link(arg)
      # {ExtensionsHelloWorld.Worker, arg}
    ]

    opts = [strategy: :one_for_one, name: ExtensionsHelloWorld.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
