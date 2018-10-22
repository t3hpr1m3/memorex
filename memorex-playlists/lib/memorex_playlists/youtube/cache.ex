defmodule MemorexPlaylists.YouTube.Cache do
  use GenServer

  def start_link(playlists \\ %{}) do
    GenServer.start_link(__MODULE__, playlists, name: __MODULE__)
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def put(id, playlist) do
    GenServer.cast(__MODULE__, {:put, id, playlist})
  end

  def clear() do
    GenServer.cast(__MODULE__, {:clear})
  end

  @impl true
  def init(playlists) do
    {:ok, playlists}
  end

  @impl true
  def handle_call({:get, id}, _from, state) do
    if Map.has_key?(state, id) do
      {:reply, {:ok, state[id]}, state}
    else
      {:reply, {:ok, nil}, state}
    end
  end

  @impl true
  def handle_cast({:put, id, playlist}, state) do
    {:noreply, Map.merge(state, %{id => playlist})}
  end

  @impl true
  def handle_cast({:clear}, state) do
    {:noreply, %{}}
  end
end
