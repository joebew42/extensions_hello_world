defmodule ExtensionsHelloWorld.MixProject do
  use Mix.Project

  def project do
    [
      app: :extensions_hello_world,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ExtensionsHelloWorld.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:joken, "~> 2.0"},
      {:jason, "~> 1.1"},
    ]
  end
end
