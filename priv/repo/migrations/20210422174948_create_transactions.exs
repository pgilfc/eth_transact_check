defmodule EthTransactCheck.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :hash, :string
      add :status, :boolean, default: false, null: false
      add :block_number, :integer
      add :is_complete, :boolean, default: false, null: false

      timestamps()
    end

  end
end
