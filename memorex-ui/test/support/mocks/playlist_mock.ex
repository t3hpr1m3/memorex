defmodule Memorex.Mocks.PlaylistMock do
  defmodule Playlist do
  end

  def fetch("1") do
    {:ok, %{playlist: %{}}}
  end

  def fetch("0") do
    {:err, :not_found}
  end
end
