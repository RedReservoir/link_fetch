defmodule LinkFetch.MixProject do
  use Mix.Project

  def project do
    [
      app: :link_fetch,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      name: "LinkFetch",
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do [] end

  defp description do
    "Small test project to extract links from tags from an HTML file"
  end

  defp package() do
    [
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: [],
      links: %{}
    ]
  end
end
