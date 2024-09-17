defmodule ConfrontoPoison.MixProject do
  use Mix.Project

  def project do
    [
      app: :confronto_poison,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 6.0"},
      {:benchee, "~> 1.3.1", only: :dev}
    ]
  end
end
