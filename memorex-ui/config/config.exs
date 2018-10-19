# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :memorex, MemorexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TSd2vYL1TtmHb/+M2YoYrZzpaeSrQTMC8ex60MQPeslns02j85MSsgncRVCE4YBG",
  render_errors: [view: MemorexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Memorex.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :memorex, :api_url, Map.fetch!(System.get_env(), "MEMOREX_API_URL")

config :memorex, :playlist_api, Memorex.Playlist
config :memorex, :http_client, HTTPoison

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
