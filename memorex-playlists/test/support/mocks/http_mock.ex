defmodule MemorexPlaylists.Mocks.HttpMock do
  @root_url "https://www.googleapis.com/youtube/v3"

  def get(url) do
    if String.starts_with?(url, @root_url) do
      get(url, String.replace(url, @root_url, ""))
    else
      raise ArgumentError, message: "No match found for url: #{url}"
    end
  end

  defp get(_, "/playlists?id=invalidID&key=API_KEY&part=snippet") do
    non_existent_playlist()
  end

  defp get(_, "/playlists?id=validID&key=API_KEY&part=snippet") do
    valid_playlist()
  end

  defp get(_, "/playlistItems?key=API_KEY&maxResults=50&part=snippet%2Cstatus&playlistId=validID") do
    playlist_items_page_1()
  end

  defp get(_, "/playlistItems?key=API_KEY&maxResults=50&pageToken=CAEQAA&part=snippet%2Cstatus&playlistId=validID") do
    playlist_items_page_2()
  end

  defp non_existent_playlist() do
    {
      :ok,
      %{
        body: Jason.encode!(%{
          kind: "youtube#playlistListResponse",
          etag: "asdflkjasdl;kfjasdl;kfjas;dfklj",
          pageInfo: %{
            totalResults: 0,
            resultsPerPage: 5
          },
          items: []
        }),
        status_code: 200
      }
    }
  end

  defp valid_playlist() do
    {
      :ok,
      %{
        body: Jason.encode!(%{
          kind: "youtube#playlistListResponse",
          etag: "\"someetag\"",
          pageInfo: %{ totalResults: 1, resultsPerPage: 5 },
          items: [
            %{
              kind: "youtube#playlist",
              etag: "\"someetag\"",
              id: "validID",
              snippet: %{
                publishedAt: "2013-10-10T16:32:16.000Z",
                channelId: "UCH-_hzb2ILSCo9ftVSnrCIQ",
                title: "Test Playlist",
                description: "A Test Playlist",
                thumbnails: %{
                  default: %{
                    url: "https://youtube.com/default.jpg",
                    width: 120,
                    height: 90
                  },
                  medium: %{
                    url: "https://youtube.com/medium.jpg",
                    width: 320,
                    height: 180
                  },
                  high: %{
                    url: "https://youtube.com/high.jpg",
                    width: 480,
                    height: 360
                  },
                  standard: %{
                    url: "https://youtube.com/standard.jpg",
                    width: 640,
                    height: 480
                  },
                  maxres: %{
                    url: "https://youtube.com/maxres.jpg",
                    width: 1280,
                    height: 720
                  }
                },
                channelTitle: "Test Channel",
                localized: %{
                  title: "Test Channel",
                  description: "A Test Channel"
                }
              }
            }
          ]
        }),
        status_code: 200
      }
    }
  end

  defp playlist_items_page_1() do
    {
      :ok,
      %{
        body: Jason.encode!(%{
          kind: "youtube#playlistItemListResponse",
          etag: "\"someetag\"",
          nextPageToken: "CAEQAA",
          pageInfo: %{
            totalResults: 51,
            resultsPerPage: 50
          },
          items: Enum.reduce(1..50, [], &add_playlist_item/2)
        }),
        status_code: 200
      }
    }
  end

  defp playlist_items_page_2() do
    {
      :ok,
      %{
        body: Jason.encode!(%{
          kind: "youtube#playlistItemListResponse",
          etag: "\"someetag\"",
          pageInfo: %{
            totalResults: 51,
            resultsPerPage: 50
          },
          items: add_playlist_item(51, [])
        }),
        status_code: 200
      }
    }
  end

  defp add_playlist_item(idx, acc) do
    [%{
      kind: "youtube#playli9stItem",
      etag: "\"someetag\"",
      id: "video#{idx}",
      snippet: %{
        publishedAt: "2013-10-10T16:32:41.000Z",
        channelId: "UCH-_hzb2ILSCo9ftVSnrCIQ",
        title: "Playlist Video #{idx}",
        description: "The Playlist Video #{idx}",
        thumbnails: %{
          default: %{
            url: "https://youtube.com/default.jpg",
            width: 120,
            height: 90
          },
          medium: %{
            url: "https://youtube.com/medium.jpg",
            width: 320,
            height: 180
          },
          high: %{
            url: "https://youtube.com/high.jpg",
            width: 480,
            height: 360
          },
          standard: %{
            url: "https://youtube.com/standard.jpg",
            width: 640,
            height: 480
          },
          maxres: %{
            url: "https://youtube.com/maxres.jpg",
            width: 1280,
            height: 720
          }
        },
        channelTitle: "Test Channel",
        playlistId: "123456",
        position: idx,
        resourceId: %{
          kind: "youtube#video",
          videoId: "video#{idx}"
        }
      },
      status: %{
        privacyStatus: "public"
      }
    } | acc]
  end
end
