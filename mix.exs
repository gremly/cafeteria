defmodule Cafeteria.MixProject do
  use Mix.Project

  def project do
    [
      app: :cafeteria,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:uuid, "~> 1.1"},
      {:decimal, "~> 2.1"},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false}
    ]
  end
end
