defmodule CafeteriaTest do
  use ExUnit.Case
  doctest Cafeteria

  test "greets the world" do
    assert Cafeteria.hello() == :world
  end
end
