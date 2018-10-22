defmodule MemorexPlaylists.YouTubeTest do
  use ExUnit.Case
  alias MemorexPlaylists.YouTube

  setup do
    on_exit fn ->
      MemorexPlaylists.YouTube.Cache.clear()
    end
    :ok
  end

  describe ".fetch with an invalid ID" do
    test "returns an error" do
      assert {:error, :not_found} == YouTube.fetch("invalidID")
    end
  end

  describe ".fetch with a valid ID" do
    test "returns a playlist title" do
      {:ok, %YouTube.Playlist{} = playlist} = YouTube.fetch("validID")
      assert playlist.title == "Test Playlist"
    end

    test "returns a list of thumbnails" do
      {:ok, %YouTube.Playlist{} = playlist} = YouTube.fetch("validID")
      assert playlist.thumbnails == %{
        default: %YouTube.Playlist.Thumbnail{
          url: "http://www.youtube.com/default.jpg",
          width: "10",
          height: "20"
        },
        high: %YouTube.Playlist.Thumbnail{
          url: "http://www.youtube.com/high.jpg",
          width: "10",
          height: "20"
        },
        maxres: %YouTube.Playlist.Thumbnail{
          url: "http://www.youtube.com/maxres.jpg",
          width: "10",
          height: "20"
        },
        medium: %YouTube.Playlist.Thumbnail{
          url: "http://www.youtube.com/medium.jpg",
          width: "10",
          height: "20"
        },
        standard: %YouTube.Playlist.Thumbnail{
          url: "http://www.youtube.com/standard.jpg",
          width: "10",
          height: "20"
        }
      }
    end

    test "returns a list of items" do
      {:ok, %YouTube.Playlist{} = playlist} = YouTube.fetch("validID")
      assert playlist.items == [
        %YouTube.Playlist.PlaylistItem{
          title: "Test Video",
          position: "0",
          thumbnails: %{
            default: %YouTube.Playlist.Thumbnail{
              url: "http://www.youtube.com/default.jpg",
              width: "10",
              height: "20"
            },
            high: %YouTube.Playlist.Thumbnail{
              url: "http://www.youtube.com/high.jpg",
              width: "10",
              height: "20"
            },
            maxres: %YouTube.Playlist.Thumbnail{
              url: "http://www.youtube.com/maxres.jpg",
              width: "10",
              height: "20"
            },
            medium: %YouTube.Playlist.Thumbnail{
              url: "http://www.youtube.com/medium.jpg",
              width: "10",
              height: "20"
            },
            standard: %YouTube.Playlist.Thumbnail{
              url: "http://www.youtube.com/standard.jpg",
              width: "10",
              height: "20"
            }
          }
        }
      ]
    end

    test "stores the playlist in the cache" do
      {:ok, %YouTube.Playlist{} = fetched} = YouTube.fetch("validID")
      {:ok, %YouTube.Playlist{} = cached} = YouTube.Cache.get("validID")
      assert Map.equal?(fetched, cached)
    end

    test "returns value from the cache" do
      YouTube.Cache.put("validID", %YouTube.Playlist{title: "TEST_VALUE"})
      {:ok, %YouTube.Playlist{} = playlist} = YouTube.fetch("validID")
      assert playlist.title == "TEST_VALUE"
    end
  end
end
