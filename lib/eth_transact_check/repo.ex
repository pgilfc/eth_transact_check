defmodule EthTransactCheck.Repo do
  use Ecto.Repo,
    otp_app: :eth_transact_check,
    adapter: Ecto.Adapters.Postgres
end
