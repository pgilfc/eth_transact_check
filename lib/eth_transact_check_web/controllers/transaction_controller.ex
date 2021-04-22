defmodule EthTransactCheckWeb.TransactionController do
  use EthTransactCheckWeb, :controller

  alias EthTransactCheck.Transactions
  alias EthTransactCheck.Transactions.Transaction

  def index(conn, _params) do
    transactions = Transactions.list_transactions()
    render(conn, "index.html", transactions: transactions)
  end

  def new(conn, _params) do
    changeset = Transactions.change_transaction(%Transaction{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    case Transactions.create_transaction(transaction_params) do
      {:ok, transaction} ->
        conn
        |> put_flash(:info, "Transaction created successfully.")
        |> redirect(to: Routes.transaction_path(conn, :show, transaction))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    render(conn, "show.html", transaction: transaction)
  end

end
