defmodule Memorex.Playlist do
  def fetch(id) do
    {:ok, %{body: raw_body, status_code: code}} =
      Memorex.http_client().get(build_url("/playlists/#{id}"))

    case code do
      200 ->
        {:ok, Jason.decode!(raw_body, keys: :atoms)}
      404 ->
        {:err, :not_found}
    end
  end

  defp build_url(path) do
    "#{Application.get_env(:memorex, :api_url)}#{path}"
  end
end
