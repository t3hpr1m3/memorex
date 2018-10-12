defmodule MemorexWeb.PlaylistController do
  use MemorexWeb, :controller

  def show(conn, %{"id" => id}) do
    {:ok, %Memorex.Playlist{} = playlist} = Memorex.Playlist.fetch(id)
    render(conn, "show.json", playlist: playlist)
  end
end
