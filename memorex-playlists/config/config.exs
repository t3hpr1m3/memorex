# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :memorex_playlists, MemorexPlaylistsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZA0bp51tLhfeB5X+psXSBsYX2JXh4E3jzFMZ86YCZPEPXTHQlsspGE8O/lAB+buG",
  render_errors: [view: MemorexPlaylistsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MemorexPlaylists.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :memorex_playlists, :http_client, HTTPoison
config :memorex_playlists, :youtube_api, MemorexPlaylists.YouTube.Client

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
