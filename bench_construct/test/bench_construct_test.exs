defmodule BenchConstructTest do
  use ExUnit.Case
  doctest BenchConstruct

  test "greets the world" do
    assert BenchConstruct.hello() == :world
  end
end
