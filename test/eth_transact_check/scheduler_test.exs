defmodule EthTransactCheck.TestScheduler do
  use EthTransactCheck.DataCase

  alias EthTransactCheck.Scheduler
  alias EthTransactCheck.Transactions

  describe "scheduler" do

    @valid_attrs  [
      {%{hash: "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315cf7"}, true, true },
      {%{hash: "0x72a54048feae2954221fe2ad4cd24309b54e3a79b9774f95c2d69bdd0549dc68"}, true, true },
      {%{hash: "0xe713f676721ee6f38ae18326cd245ccf7d57eab8dc2fb57d30dedff11151315a"}, true, true },
      {%{hash: "0xb861886d3f11433bcd0a3c8ba7059170f43c53962e149b00e5c493935f859b0c"}, true, true },
      {%{hash: "0xe1fb325b4d82511f9617e531fbc19688ec4036559e9f3117279b1413fe1c24e5"}, true, true },
      {%{hash: "0x743d8bbbd2260c48265435416ef9ea2ed898ca5dd93ad1455c14b61a233c26ca"}, true, true },
      {%{hash: "0x2da79b213d5a5d42f598dbd45c522e064a7378cf8cc5876e03703a215ef71a67"}, false, false },
      {%{hash: "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315cf1"}, false, false }
    ]

    def scheduler_fixture() do
      @valid_attrs
      |> Enum.each(fn {attrs, _, _} ->
        {:ok, _} =
          attrs
          |> Transactions.create_transaction()
      end)
    end

    test "validate_transactions/0 validate all pending transactions" do
      scheduler_fixture()
      Scheduler.validate_transactions()
      Enum.each(@valid_attrs, fn {attrs, validity, _} ->
        assert Transactions.get_transaction_by_hash!(attrs.hash).status == validity
      end)
    end

    test "validate_transaction_completion/0 validate completion on approved transactions" do
      scheduler_fixture()
      Scheduler.validate_transactions()
      Scheduler.validate_transaction_completion()
      Enum.each(@valid_attrs, fn {attrs, _, completion} ->
        assert Transactions.get_transaction_by_hash!(attrs.hash).is_complete == completion
      end)
    end

  end
end
