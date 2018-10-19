defmodule Memorex.PlaylistTest do
  use ExUnit.Case

  describe ".fetch" do
    test "with a 200 from API returns a playlist" do
      {:ok, res} = Memorex.Playlist.fetch(1)
      assert %{
        playlist: %{
          title: _,
          thumbnails: %{
            default: %{url: _, width: _, height: _},
            high: %{url: _, width: _, height: _},
            maxres: %{url: _, width: _, height: _},
            medium: %{url: _, width: _, height: _},
            standard: %{url: _, width: _, height: _}
          },
          videos: [
            %{
              title: _,
              thumbnails: %{
                default: %{url: _, width: _, height: _},
                high: %{url: _, width: _, height: _},
                maxres: %{url: _, width: _, height: _},
                medium: %{url: _, width: _, height: _},
                standard: %{url: _, width: _, height: _}
              }
            }
          ]
        }
      } = res
    end

    test "with a 404 from API returns a :not_found error" do
      {:err, err} = Memorex.Playlist.fetch(0)
      assert :not_found = err
    end
  end
end
