defmodule MemorexPlaylists.Mocks.YouTubeMock do
  alias MemorexPlaylists.YouTube.Playlist

  def fetch("invalidID") do
    {:error, :not_found}
  end

  def fetch("validID") do
    {:ok, %Playlist{
      title: "Test Playlist",
      thumbnails: thumbnails(),
      items: [
        %Playlist.PlaylistItem{
          title: "Test Video",
          thumbnails: thumbnails(),
          position: "0"
        }
      ]
    }}
  end

  defp thumbnails() do
    ~w(default high maxres medium standard)a
    |> Enum.reduce(%{}, fn(size, acc) ->
      Map.put(acc, size, %Playlist.Thumbnail{
        url: "http://www.youtube.com/#{size}.jpg",
        width: "10",
        height: "20"
      })
    end)
  end
end
