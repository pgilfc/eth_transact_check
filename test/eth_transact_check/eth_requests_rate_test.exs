defmodule EthTransactCheck.EthRequestsRateTest do
  use ExUnit.Case

  alias EthTransactCheck.EthRequestsRate

  test "rate count" do
    EthRequestsRate.start_link()
    assert {_, 5} = EthRequestsRate.read()
    assert {_, 4} = EthRequestsRate.count()
  end

end
