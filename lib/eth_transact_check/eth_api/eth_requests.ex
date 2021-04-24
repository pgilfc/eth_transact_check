defmodule EthTransactCheck.EthRequests do

  alias EthTransactCheck.EthRequestsRate

  @jsonrpc "2.0"
  @api_key Application.fetch_env!(:eth_transact_check, EthTransactCheck.EthRequests)[:api_key]
  @url "https://api.etherscan.io/api"

  def eth_block_number do
    "#{@url}?module=proxy&action=eth_blockNumber&apikey=#{@api_key}"
    |> HTTPoison.get()
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body }} ->
        case Jason.decode!(body) do
          %{"jsonrpc" => @jsonrpc, "result" => block_number}  ->
            {:ok, block_number}
          _ ->
            {:error, body}
        end
      _ ->
        {:error, "eth_blockNumber couldn't connect"}
    end
  end

  def eth_get_transaction_receipt(hash) do
    "#{@url}?module=proxy&action=eth_getTransactionReceipt&txhash=#{hash}&apikey=#{@api_key}"
    |> HTTPoison.get()
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body }} ->
        case Jason.decode!(body) do
          %{"jsonrpc" => @jsonrpc, "result" => transaction_receipt}  ->
            {:ok, transaction_receipt}
          _ ->
            {:error, body}
        end
      _ ->
        {:error, "eth_get_transaction_receipt couldn't connect"}
    end
  end

  def eth_get_transaction_details(hash) do
    eth_get_transaction_receipt(hash)
    |> case do
      {:ok, %{"blockNumber" => block_number, "status" => status}} ->
        {:ok, %{block_number: parse_block_number(block_number), status: receipt_status(status)}}
      {:error, body} ->
        {:error, body}
    end
  end

  defp receipt_status("0x1"), do: true
  defp receipt_status("0x0"), do: false

  defp parse_block_number("0x" <> blockNumber) do
    {intVal, ""} = blockNumber
      |> Integer.parse(16)
    intVal
  end

end
