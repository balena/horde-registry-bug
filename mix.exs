defmodule HordeRegistryBug.MixProject do
  use Mix.Project

  def project do
    [
      app: :horde_registry_bug,
      version: "0.1.0",
      elixir: "~> 1.10",
     deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HordeRegistryBug.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:libcluster, "~> 3.2"},
      {:horde, "~> 0.8.0-rc.1"}
    ]
  end
end
