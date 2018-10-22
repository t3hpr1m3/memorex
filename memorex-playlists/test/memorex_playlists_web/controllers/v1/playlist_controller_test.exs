defmodule MemorexPlaylistsWeb.V1.PlaylistControllerTest do
  use MemorexPlaylistsWeb.ConnCase

  describe "retrieving playlist from YouTube" do
    test "non-existent id returns Invalid Playlist ID error", %{conn: conn} do
      conn = get(conn, "/v1/playlists/invalidID")
      assert %{"errors" => ["Invalid Playlist ID"]} = json_response(conn, 404)
    end

    test "valid id returns a playlist", %{conn: conn} do
      conn = get(conn, "/v1/playlists/validID")
      assert %{"playlist" => %{}} = json_response(conn, 200)
    end
  end
end
