defmodule MemorexWeb.Router do
  use MemorexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", MemorexWeb.Api.V1 do
    pipe_through :api

    resources("/playlists", PlaylistController, only: [:show])
  end

  scope "/", MemorexWeb do
    pipe_through :browser

    get "/*anything", PageController, :index
  end
end
