defmodule EthTransactCheck.EthRequestsTest do
  use ExUnit.Case

  alias EthTransactCheck.EthRequests

  describe "eth_requests" do

    @valid_hash  "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315cf7"
    @invalid_hash "0x856a8ed99754fd8948b3ad60ed2b381401ddbcb34d754803d8136c4ae4315c"

    test "eth_block_number/0 returns block number" do
      assert {:ok, "0x"<> _} = EthRequests.eth_block_number()
    end

    test "eth_get_transaction_receipt/1 returns transaction receipt" do
      assert {:ok, %{"status"=> _status, "blockNumber"=> _block}} = EthRequests.eth_get_transaction_receipt(@valid_hash)
      assert {:error, _error_message} = EthRequests.eth_get_transaction_receipt(@invalid_hash)
    end

    test "eth_get_transaction_receipt/1 testing api timeout" do
      Process.sleep(1000)
      assert {:ok, %{"status"=> _status, "blockNumber"=> _block}} = EthRequests.eth_get_transaction_receipt(@valid_hash)
      assert {:ok, %{"status"=> _status, "blockNumber"=> _block}} = EthRequests.eth_get_transaction_receipt(@valid_hash)
      assert {:ok, %{"status"=> _status, "blockNumber"=> _block}} = EthRequests.eth_get_transaction_receipt(@valid_hash)
      assert {:ok, %{"status"=> _status, "blockNumber"=> _block}} = EthRequests.eth_get_transaction_receipt(@valid_hash)
      assert {:ok, %{"status"=> _status, "blockNumber"=> _block}} = EthRequests.eth_get_transaction_receipt(@valid_hash)
      assert {:error, _error_message} = EthRequests.eth_get_transaction_receipt(@valid_hash)
    end

  end

end
