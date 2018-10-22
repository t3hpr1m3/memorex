defmodule MemorexPlaylists do
  @moduledoc """
  MemorexPlaylists keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def apis(name) do
    case name do
      :youtube ->
        Application.get_env(:memorex_playlists, :youtube_api)
    end
  end

  def http_client() do
    Application.get_env(:memorex_playlists, :http_client)
  end
end
