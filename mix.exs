defmodule BetterMangler.MixProject do
  use Mix.Project

  def project do
    [
      app: :better_mangler,
      version: "0.1.0",
      elixir: "~> 1.6",
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
      {:poison, "~> 3.1"},
      {:inflex, "~> 1.10.0"},
      {:verbs, git: "https://github.com/shannonwells/verbs_ex.git"},
      {:random_word_service,
       git: "https://github.com/patrickcarver/random_word_service.git", tag: "v0.2"}
    ]
  end
end
