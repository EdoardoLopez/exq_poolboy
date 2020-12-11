defmodule ExqPoolboy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: ExqPoolboy.Worker.start_link(arg)
      # {ExqPoolboy.Worker, arg},
      supervisor(ExqPoolboy.PoolboySup, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExqPoolboy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
