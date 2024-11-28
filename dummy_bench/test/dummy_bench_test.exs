defmodule DummyBenchTest do
  use ExUnit.Case
  doctest DummyBench

  test "greets the world" do
    assert DummyBench.hello() == :world
  end
end
