defmodule LinkFetch.MixProject do
  use Mix.Project

  def project do
    [
      app: :link_fetch,
      version: "0.1.3",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      name: "LinkFetch",
      package: package(),
      source_url: "https://github.com/RedReservoir/link_fetch"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
    ]
  end

  defp description do
    "Small test project to extract links from tags from an HTML file"
  end

  defp package() do
    [
      licenses: [],
      links: %{"GitHub" => "https://github.com/RedReservoir/link_fetch"}
    ]
  end
end
