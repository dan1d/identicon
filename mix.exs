defmodule Identicon.MixProject do
  use Mix.Project

  def project do
    [
      app: :identicon,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/dan1d/identicon",
      homepage_url: "https://github.com/dan1d/identicon",
      docs: docs()
    ]
  end

  def docs do
    [
      main: "intro",
      extras: ["docs/static/Intro.md"],
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
      {:egd, github: "erlang/egd"},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end

  def description do
    "Package to create an image based on a string as github does. It allways returns the same output for the same input."
  end

  def package do
    [
      name: "identicon",
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/dan1d/identicon",
        "Docs" => "https://dan1d.github.io/identicom/"
      },
      maintainers: ["dan1d"]
    ]
  end
end
