defmodule MemorexPlaylists.YouTube.Client do
  alias MemorexPlaylists.YouTube.Playlist

  @root_url "https://www.googleapis.com/youtube/v3"

  def fetch(id) do
    with {:ok, %Playlist{} = playlist} <- fetch_data(id),
         {:ok, [%Playlist.PlaylistItem{} | _] = items} <- fetch_items(id) do
      {:ok, Map.merge(
        playlist,
        %{items: Enum.sort(items, fn(a, b) -> a.position < b.position end)}
      )}
    else
      err ->
        err
    end
  end

  defp fetch_data(id) do
    params = %{id: id, part: "snippet"}

    case make_request("playlists", params) do
      {:ok, %{pageInfo: %{totalResults: 0}}} ->
        {:error, :not_found}
      {:ok, %{items: items}} ->
        {:ok, snippet} = items |> List.first() |> Map.fetch(:snippet)
        {:ok, %Playlist{
          title: snippet[:title],
          thumbnails: extract_thumbnails(snippet[:thumbnails])
        }}
    end
  end

  defp fetch_items(id) do
    fetch_items([], id, nil)
  end

  defp fetch_items(items, id, %{nextPageToken: token}) do
    fetch_items(items, id, token)
  end

  defp fetch_items(items, _, %{}) do
    {:ok, items}
  end

  defp fetch_items(items, id, token) do
    params = %{
      playlistId: id,
      maxResults: 50,
      part: "snippet,status",
      pageToken: token
    }

    case make_request("playlistItems", params) do
      {:ok, %{items: new_items} = res} ->
        Enum.reduce(new_items, items, &handle_item/2)
        |> fetch_items(id, res)
    end
  end

  defp handle_item(%{status: %{privacyStatus: status}, snippet: snippet}, acc) do
    handle_item(status, snippet, acc)
  end

  defp handle_item("public", snippet, acc) do
    %{title: title, thumbnails: thumbnails, position: position} = snippet
    [%Playlist.PlaylistItem{
      title: title,
      thumbnails: extract_thumbnails(thumbnails),
      position: position
    } | acc]
  end

  defp handle_item(_, _, acc) do
    acc
  end

  defp make_request(resource, params) do
    client = MemorexPlaylists.http_client()
    {:ok, %{body: raw_body, status_code: code}} =
      build_url(resource, params)
      |> client.get()

    case code do
      200 ->
        {:ok, Jason.decode!(raw_body, keys: :atoms)}
    end
  end

  defp build_url(resource, params) do
    Enum.join([@root_url, resource], "/")
    |> URI.parse()
    |> Map.put(:query, build_params(params))
    |> URI.to_string()
  end

  defp build_params(params) do
    Enum.reject(params, fn {_, v} -> is_nil(v) end)
    |> Map.new()
    |> Map.merge(%{key: System.get_env("YOUTUBE_API_KEY")})
    |> URI.encode_query()
  end

  defp extract_thumbnails(data) do
    ~w(default high maxres medium standard)a
    |> Enum.reduce(%{}, fn(size, acc) ->
      if Map.has_key?(data, size) do
        acc
        |> Map.put(size, %Playlist.Thumbnail{
          width: data[size][:width],
          height: data[size][:height],
          url: data[size][:url]
        })
      else
        acc
      end
    end)
  end
end
