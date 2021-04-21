# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :eth_transact_check,
  ecto_repos: [EthTransactCheck.Repo]

# Configures the endpoint
config :eth_transact_check, EthTransactCheckWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "40mRK854oWZhtDESsPX81wQTRgmbSiDwPAmQv+C/nnPORWOtrOcMFkkT2NDY9s1C",
  render_errors: [view: EthTransactCheckWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EthTransactCheck.PubSub,
  live_view: [signing_salt: "pcM7amXX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
