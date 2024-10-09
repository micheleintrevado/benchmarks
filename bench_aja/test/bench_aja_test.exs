defmodule BenchAjaTest do
  use ExUnit.Case
  doctest BenchAja

  test "greets the world" do
    assert BenchAja.hello() == :world
  end
end
