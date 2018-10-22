defmodule MemorexPlaylists.TestHelpers do
  defmacro __using__([]) do
    quote do
      @sizes ~w(default high maxres medium standard)a

      def mock_thumbnails(:atoms) do
        @sizes
        |> Enum.reduce(%{}, fn(size, acc) ->
          Map.put(acc, size, %MemorexPlaylists.Playlist.Thumbnail{
            url: "http://www.youtube.com/#{size}.jpg",
            width: "10",
            height: "20"
          })
        end)
      end

      def mock_thumbnails(:strings) do
        @sizes
        |> Enum.reduce(%{}, fn(size, acc) ->
          Map.put(acc, Atom.to_string(size), %{
            "url" => "http://www.youtube.com/#{size}.jpg",
            "width" => "10",
            "height" => "20"
          })
        end)
      end
    end
  end
end
