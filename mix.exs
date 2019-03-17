defmodule GRPC.Mixfile do
  use Mix.Project

  @version "0.3.1"

  def project do
    [
      app: :grpc,
      version: @version,
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "The Elixir implementation of gRPC",
      docs: [
        extras: ["README.md"],
        main: "readme",
        source_ref: "v#{@version}",
        source_url: "https://github.com/tony612/grpc-elixir"
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    ex_doc_version =
      if System.version() |> Version.compare("1.7.0") == :lt do
        "~> 0.18.0"
      else
        "~> 0.19"
      end

    [
      {:protobuf, "~> 0.5"},
      {:cowboy, "~> 2.6.1"},
      {:gun, github: "ninenines/gun"},
      {:ex_doc, ex_doc_version, only: :dev},
      {:inch_ex, "~> 1.0", only: [:dev, :test]},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false}
    ]
  end

  defp package do
    %{
      maintainers: ["Bing Han"],
      licenses: ["Apache 2"],
      links: %{"GitHub" => "https://github.com/tony612/grpc-elixir"},
      files: ~w(mix.exs README.md lib src config LICENSE .formatter.exs)
    }
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
