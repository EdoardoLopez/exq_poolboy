defmodule ExqPoolboy.PoolboyWorker do
  use GenServer
  require Logger

  def test do
    # with
    for i <- 1..5 do
      Logger.info "POOLBOY SUP STATUS"
      {status, poolsize_av, overflow_us, pool_us} = ExqPoolboy.PoolboySup.status()
      |> IO.inspect
      case status do
        :full ->
          Logger.info "LOCAL POOLBOY ENQUEUE #{i}"
        _ ->
          worker_pid = ExqPoolboy.PoolboySup.checkout()
          GenServer.call(worker_pid, {:pool_checkout, %{worker: worker_pid}})
      end
    end
  end

  # Server (Callbacks)
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  def init(args \\ []), do: {:ok, args}

  # Call & cast callbacks
  def handle_call({:pool_checkout, args}, from, state) do
    # worker_pid = PoolboySup.checkout()

    # TODO: Return valid data to monitor.
    {:reply, {:ok, args.worker}, state}
  end
end
