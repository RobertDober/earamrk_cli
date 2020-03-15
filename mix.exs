defmodule EarmarkCli.MixProject do
  use Mix.Project

  @version "0.1.0"
  @url "https://github.com/robertdober/earmark_cli"

  def project do
    [ app: :earmark_cli,
      aliases: [docs: &build_docs/1],
      version: "0.1.0",
      elixir: "~> 1.10",
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

      # {:earmark, "~> 1.5.0"}
      # 1.5.0 is not available yet, 1.4.3 will not work with all options, do not release yet!!!
      # Release depends on 1.5.0
      # Maybe use github or file dependency instead for better testing
      {:earmark, "~> 1.4.3"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  @prerequisites """
  run `mix escript.install hex ex_doc` and adjust `PATH` accordingly
  """
  defp build_docs(_) do
    Mix.Task.run("compile")
    ex_doc = Path.join(Mix.path_for(:escripts), "ex_doc")
    Mix.shell().info("Using escript: #{ex_doc} to build the docs")

    unless File.exists?(ex_doc) do
      raise "cannot build docs because escript for ex_doc is not installed, make sure to \n#{@prerequisites}"
    end

    args = ["EarmarkCLI", @version, Mix.Project.compile_path()]
    opts = ~w[--main EarmarkCLI --source-ref v#{@version} --source-url #{@url}]

    Mix.shell().info("Running: #{ex_doc} #{inspect(args ++ opts)}")
    System.cmd(ex_doc, args ++ opts)
    Mix.shell().info("Docs built successfully")
  end

end
