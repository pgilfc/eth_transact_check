defmodule EthTransactCheck.EthRequestsRateTest do
  use ExUnit.Case

  alias EthTransactCheck.EthRequestsRate

  test "rate count" do
    assert {_, _, _} = EthRequestsRate.read()
    assert {_, _, _} = EthRequestsRate.count(fn -> true end)
  end

end
