defmodule EthTransactCheck.Scheduler do
  use Quantum, otp_app: :eth_transact_check

  alias EthTransactCheck.EthRequestsRate
  alias EthTransactCheck.EthRequests
  alias EthTransactCheck.Transactions

  @block_confirmation 2

  @doc """
  Transverse the list of pending transactions and check if they are valid.
  """
  def validate_transactions do
    Transactions.list_transactions_pending()
    |> Enum.each(fn transaction ->
      EthRequestsRate.count(fn ->
        with {:ok, %{block_number: _, status: _} = attrs} <- EthRequests.eth_get_transaction_receipt_details(transaction.hash) do
          Transactions.update_transaction(transaction, attrs)
        end
      end)
    end)
  end

  @doc """
  Transverse the list of valid transactions and check if they are completed.
  """
  def validate_transaction_completion do
    with {_,_,{:ok, current_block_number}} <- EthRequestsRate.count(fn -> EthRequests.eth_block_number_integer() end) do
      Transactions.list_transactions_awaiting_completion()
      |> Enum.each(fn transaction ->
        EthRequestsRate.count(fn ->
          with {:ok, %{block_number: block_number}} <- EthRequests.eth_get_transaction_receipt_details(transaction.hash) do
            diff = current_block_number - block_number
            if diff >= @block_confirmation do
              Transactions.update_transaction(transaction, %{is_complete: true})
            end
          end
        end)
      end)
    end
  end

end
