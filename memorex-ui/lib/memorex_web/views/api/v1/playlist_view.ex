defmodule MemorexWeb.Api.V1.PlaylistView do
  use MemorexWeb, :view

  def render("show.json", %{playlist: playlist}) do
    %{playlist: playlist}
  end
end
