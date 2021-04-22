defmodule EthTransactCheckWeb.TransactionControllerTest do
  use EthTransactCheckWeb.ConnCase

  alias EthTransactCheck.Transactions

  @create_attrs %{block_number: nil, hash: "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315cf7", is_complete: false, status: false}
  @invalid_attrs %{block_number: nil, hash: "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315cf", is_complete: false, status: false}

  def fixture(:transaction) do
    {:ok, transaction} = Transactions.create_transaction(@create_attrs)
    transaction
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, Routes.transaction_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Transactions"
    end
  end

  describe "new transaction" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.transaction_path(conn, :new))
      assert html_response(conn, 200) =~ "New Transaction"
    end
  end

  describe "create transaction" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.transaction_path(conn, :show, id)

      conn = get(conn, Routes.transaction_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Transaction"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Transaction"
    end
  end

end
