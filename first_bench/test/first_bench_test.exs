defmodule FirstBenchTest do
  use ExUnit.Case
  doctest FirstBench

  test "greets the world" do
    assert FirstBench.hello() == :world
  end
end
