defmodule MemorexPlaylistsWeb.V1.PlaylistView do
  use MemorexPlaylistsWeb, :view
  alias MemorexPlaylists.YouTube.Playlist

  def render("show.json", %{playlist: %Playlist{} = playlist}) do
    %{playlist: playlist}
  end
end
