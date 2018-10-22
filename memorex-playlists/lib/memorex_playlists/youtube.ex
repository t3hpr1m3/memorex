defmodule MemorexPlaylists.YouTube do
  use Supervisor

  alias MemorexPlaylists.YouTube.Cache
  alias MemorexPlaylists.YouTube.Playlist

  def start_link(_) do
    Supervisor.start_link(__MODULE__, [])
  end

  @impl true
  def init(_) do
    children = [{Cache, %{}}]
    Supervisor.init(children, strategy: :one_for_one)
  end

  def fetch(id) do
    case Cache.get(id) do
      {:ok, %Playlist{}} = res -> res
      {:ok, nil} ->
        case MemorexPlaylists.apis(:youtube).fetch(id) do
          {:ok, %Playlist{} = playlist} ->
            Cache.put(id, playlist)
            {:ok, playlist}
          err -> err
        end
    end
  end
end
