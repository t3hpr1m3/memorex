defmodule MemorexPlaylistsWeb.Router do
  use MemorexPlaylistsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", MemorexPlaylistsWeb.V1 do
    pipe_through :api

    resources("/playlists", PlaylistController, only: [:show])
  end
end
