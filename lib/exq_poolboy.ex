defmodule ExqPoolboy do
  @moduledoc """
  Documentation for ExqPoolboy.
  """

  def test do
    {:ok, jid} = Exq.enqueue(Exq, "default", ExqPoolboy.ExqWorker, [])
  end
end
