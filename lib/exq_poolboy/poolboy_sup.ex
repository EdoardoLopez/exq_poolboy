defmodule ExqPoolboy.PoolboySup do
  use Supervisor
  alias ExqPoolboy.PoolboyWorker

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_options) do
    poolboy_opts = [
      name: {:local, poolboy_name()},
      worker_module: PoolboyWorker,
      size: poolboy_size(),
      max_overflow: 0,
      strategy: :fifo
    ]

    children = [
      :poolboy.child_spec(poolboy_name(), poolboy_opts, [])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  # Simple API wrapper around poolboy's methods.
  def checkout, do: :poolboy.checkout(poolboy_name())
  def checkin(worker), do: :poolboy.checkin(poolboy_name(), worker)
  def status, do: :poolboy.status(poolboy_name())
  def transaction(func), do: :poolboy.transaction(poolboy_name(), func)

  # Private functions
  defp poolboy_name, do: :poolboy_test
  defp poolboy_size, do: System.get_env("VIDEO_POOL_SIZE") || 2
end
