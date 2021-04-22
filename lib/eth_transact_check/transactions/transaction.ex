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
    |> cast(attrs, [:status, :block_number, :is_complete])
  end

  def create_changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:hash])
    |> validate_required([:hash])
    |> validate_format(:hash, ~r/^0x([A-Fa-f0-9]{64})$/)
    |> unique_constraint(:hash)
  end
end
