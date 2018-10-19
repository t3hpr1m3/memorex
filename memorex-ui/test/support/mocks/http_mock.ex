defmodule Memorex.Mocks.HttpMock do

  def get(url) do
    if String.starts_with?(url, Application.get_env(:memorex, :api_url)) do
      get(url, String.replace(url, Application.get_env(:memorex, :api_url), ""))
    else
      raise ArgumentError, message: "No match found for url: #{url}"
    end
  end

  def get(_, "/playlists/0") do
    {
      :ok,
      %{
        body: Jason.encode!(%{errors: %{detail: "Not Found"}}),
        status_code: 404
      }
    }
  end

  def get(_, "/playlists/1") do
    thumbnails = ~w(default high maxres medium standard)a
                 |> Enum.reduce(%{}, fn(size, acc) ->
                   Map.put(acc, Atom.to_string(size), %{
                     "url" => "http://www.google.com/#{size}.jpg",
                     "width" => "10",
                     "height" => "10"
                   })
                 end)
    {
      :ok,
      %{
        body: Jason.encode!(%{
          "playlist" => %{
            "title" => "Test Playlist",
            "thumbnails" => thumbnails,
            "videos" => [
              %{
                "title" => "Test Video",
                "thumbnails" => thumbnails
              }
            ]
          }
        }),
        status_code: 200
      }
    }
  end
end
