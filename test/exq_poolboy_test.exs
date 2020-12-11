defmodule ExqPoolboyTest do
  use ExUnit.Case
  doctest ExqPoolboy

  test "greets the world" do
    assert ExqPoolboy.hello() == :world
  end
end
