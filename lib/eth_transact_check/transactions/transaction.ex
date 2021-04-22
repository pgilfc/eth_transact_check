defmodule EthTransactCheck.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :block_number, :integer
    field :hash, :string
    field :is_complete, :boolean, default: false
    field :status, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:hash, :status, :block_number, :is_complete])
    |> validate_required([:hash, :status, :block_number, :is_complete])
  end
end
