defmodule MemorexPlaylistsWeb.V1.PlaylistController do
  use MemorexPlaylistsWeb, :controller
  alias MemorexPlaylists.YouTube

  def show(conn, %{"id" => id}) do
    case YouTube.fetch(id) do
      {:ok, %YouTube.Playlist{} = playlist} ->
        render(conn, "show.json", %{playlist: playlist})
      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> put_view(MemorexPlaylistsWeb.ErrorView)
        |> render(:"404")
    end
  end
end
