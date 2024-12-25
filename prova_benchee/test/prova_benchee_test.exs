defmodule ProvaBencheeTest do
  use ExUnit.Case
  doctest ProvaBenchee

  test "greets the world" do
    assert ProvaBenchee.hello() == :world
  end
end
