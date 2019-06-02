defmodule ExtensionsHelloWorld.MixProject do
  use Mix.Project

  def project do
    [
      app: :extensions_hello_world,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ExtensionsHelloWorld.Application, []}
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:cors_plug, "~> 2.0"},
      {:joken, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:httpoison, "~> 1.5"},
      {:mox, "~> 0.5.1", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_), do: ["lib"]
end
