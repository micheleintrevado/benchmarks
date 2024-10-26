defmodule BenchRedixTest do
  use ExUnit.Case
  doctest BenchRedix

  test "greets the world" do
    assert BenchRedix.hello() == :world
  end
end
