defmodule Soap.MixProject do
  use Mix.Project

  def project do
    [
      app: :soa,
      version: "0.1.0",
      deps: deps(),
      package: package(),
      description: "SOA Simple Object Access Protocol",
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Maxim Sokhatsky"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/voxoz/soa"}
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def deps do
    [
      {:ex_doc, "~> 0.11", only: :dev},
      {:sweet_xml, "~> 0.6.5"},
      {:httpoison, "~> 1.3"},
      {:xml_builder, "~> 2.1"},
    ]
  end
end
