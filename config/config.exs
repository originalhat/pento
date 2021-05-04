# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pento,
  ecto_repos: [Pento.Repo]

# Configures the endpoint
config :pento, PentoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4MqcNYe/JgQAOVQm4q4nXxD9G+7hmPS9ajluPN1uKmKQ3Sllq9fqfBQV0DxoOmEl",
  render_errors: [view: PentoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pento.PubSub,
  live_view: [signing_salt: "e2Ct2bKY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :pento, Pento.Mailer,
  adapter: Bamboo.MandrillAdapter,
  api_key: "my_api_key"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
