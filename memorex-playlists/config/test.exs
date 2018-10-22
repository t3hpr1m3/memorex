use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :memorex_playlists, MemorexPlaylistsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :memorex_playlists, :http_client, MemorexPlaylists.Mocks.HttpMock
config :memorex_playlists, :youtube_api, MemorexPlaylists.Mocks.YouTubeMock
