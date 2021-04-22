defmodule EthTransactCheck.TransactionsTest do
  use EthTransactCheck.DataCase

  alias EthTransactCheck.Transactions

  describe "transactions" do
    alias EthTransactCheck.Transactions.Transaction

    @valid_attrs  %{block_number: nil, hash: "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315cf7", is_complete: false, status: false}
    @update_attrs %{block_number: 43, hash: "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315cf7", is_complete: true, status: true}
    @invalid_attrs %{block_number: nil, hash: "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315c", is_complete: false, status: false}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(@valid_attrs)
      assert transaction.block_number == nil
      assert transaction.hash == "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315cf7"
      assert transaction.is_complete == false
      assert transaction.status == false
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{} = transaction} = Transactions.update_transaction(transaction, @update_attrs)
      assert transaction.block_number == 43
      assert transaction.hash == @valid_attrs.hash
      assert transaction.is_complete == true
      assert transaction.status == true
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
