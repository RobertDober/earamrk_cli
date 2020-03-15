defmodule EarmarkCliTest do
  use ExUnit.Case
  doctest EarmarkCli

  test "greets the world" do
    assert EarmarkCli.hello() == :world
  end
end
