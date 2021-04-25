defmodule EthTransactCheck.EthRequestsRate do
  @moduledoc """
  GenServer to controll api rate
  """
  use GenServer

  @calls 4

  def seconds, do: System.system_time(:second)

  def wait_until(time) do
    if seconds() < time do
      Process.sleep(100)
      wait_until(time)
    end
  end

  ### CLIENT API ###

  @doc """
  Starts registry
  """
  def start_link(_ops) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @doc """
  Stop registry
  """
  def stop do
    GenServer.stop(__MODULE__)
  end

  @doc """
  Read api calls
  """
  def read do
    GenServer.call(__MODULE__, :read)
  end

  @doc """
  Decrease api count
  """
  def count(function) do
    GenServer.cast(__MODULE__, {:count, function})
    GenServer.call(__MODULE__, :read)
  end


  ### SERVER CALLBACKS ###

  def init(:ok) do
    {:ok, {seconds(), @calls, nil}}
  end

  @doc """
  Returns current api info
  """
  def handle_call(:read, _from, store) do
    {:reply, store, store}
  end

  @doc """
  Calculates current api state
  """
  def handle_cast({:count, function}, {time, 0, _}) do
    wait_until(time + 1)
    result = function.()
    current_time = seconds()
    {:noreply, {current_time, @calls - 1, result}}
  end

  def handle_cast({:count, function}, {time, calls, _}) do
    result = function.()
    cond do
      time < seconds() ->
        current_time = seconds()
        {:noreply, {current_time, @calls - 1, result}}
      true ->
        {:noreply, {time, calls - 1, result}}
    end
  end

end
