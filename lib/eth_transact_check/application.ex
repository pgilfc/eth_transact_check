defmodule EthTransactCheck.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      EthTransactCheck.Repo,
      # Start the Telemetry supervisor
      EthTransactCheckWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: EthTransactCheck.PubSub},
      # Start the Endpoint (http/https)
      EthTransactCheckWeb.Endpoint,
      # Start a worker by calling: EthTransactCheck.Worker.start_link(arg)
      # {EthTransactCheck.Worker, arg}
      EthTransactCheck.EthRequestsRate,
      EthTransactCheck.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EthTransactCheck.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EthTransactCheckWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
