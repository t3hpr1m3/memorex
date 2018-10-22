defmodule MemorexWeb.Api.V1.PlaylistController do
  use MemorexWeb, :controller

  def show(conn, %{"id" => id}) do
    api = Memorex.apis(:playlist)
    if String.starts_with?(id, "http") do
      q = URI.parse(id)
          |> Map.get(:query)
          |> URI.decode_query()
          |> Map.get("list")
      show(conn, %{"id" => q})
    else
      case api.fetch(id) do
        {:ok, %{playlist: playlist}} ->
          render(conn, "show.json", %{playlist: playlist})
        {:err, :not_found} ->
          conn
          |> put_status(:not_found)
          |> put_view(MemorexWeb.ErrorView)
          |> render(:"404")
      end
    end
  end
end
