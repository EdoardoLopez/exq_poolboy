defmodule ExqPoolboy.ExqWorker do
  require Logger

  def perform do
    Logger.info "PERFORM FUNCTION"

    ExqPoolboy.PoolboyWorker.test()
    |> IO.inspect
  end
end
