defmodule MemorexPlaylists.YouTube.ClientTest do
  use ExUnit.Case

  alias MemorexPlaylists.YouTube

  describe ".fetch with an invalid playlist ID" do
    test "returns :not_found" do
      assert {:error, :not_found} = YouTube.Client.fetch("invalidID")
    end
  end

  describe ".fetch with a valid playlist ID" do
    test "returns a valid playlist title" do
      {:ok, %YouTube.Playlist{} = playlist} =
        MemorexPlaylists.YouTube.Client.fetch("validID")
      assert playlist.title == "Test Playlist"
    end

    test "returns a list of thumbnails" do
      {:ok, %YouTube.Playlist{} = playlist} =
        MemorexPlaylists.YouTube.Client.fetch("validID")
      assert Map.equal?(playlist.thumbnails, %{
        default: %YouTube.Playlist.Thumbnail{
          url: "https://youtube.com/default.jpg",
          width: 120,
          height: 90
        },
        medium: %YouTube.Playlist.Thumbnail{
          url: "https://youtube.com/medium.jpg",
          width: 320,
          height: 180
        },
        high: %YouTube.Playlist.Thumbnail{
          url: "https://youtube.com/high.jpg",
          width: 480,
          height: 360
        },
        standard: %YouTube.Playlist.Thumbnail{
          url: "https://youtube.com/standard.jpg",
          width: 640,
          height: 480
        },
        maxres: %YouTube.Playlist.Thumbnail{
          url: "https://youtube.com/maxres.jpg",
          width: 1280,
          height: 720
        }
      })
    end

    test "returns a list of playlist items" do
      {:ok, %YouTube.Playlist{} = playlist} =
        MemorexPlaylists.YouTube.Client.fetch("validID")
      assert is_list(playlist.items)
      playlist.items
      |> Enum.with_index()
      |> Enum.map(fn({item, idx}) ->
        assert item.title == "Playlist Video #{idx + 1}"
        assert Map.equal?(playlist.thumbnails, %{
          default: %YouTube.Playlist.Thumbnail{
            url: "https://youtube.com/default.jpg",
            width: 120,
            height: 90
          },
          medium: %YouTube.Playlist.Thumbnail{
            url: "https://youtube.com/medium.jpg",
            width: 320,
            height: 180
          },
          high: %YouTube.Playlist.Thumbnail{
            url: "https://youtube.com/high.jpg",
            width: 480,
            height: 360
          },
          standard: %YouTube.Playlist.Thumbnail{
            url: "https://youtube.com/standard.jpg",
            width: 640,
            height: 480
          },
          maxres: %YouTube.Playlist.Thumbnail{
            url: "https://youtube.com/maxres.jpg",
            width: 1280,
            height: 720
          }
        })
      end)
    end
  end
end
