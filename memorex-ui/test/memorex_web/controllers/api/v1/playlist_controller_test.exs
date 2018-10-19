defmodule MemorexWeb.Api.V1.PlaylistControllerTest do
  use MemorexWeb.ConnCase

  describe "retrieving a playlist" do
    test "non-existent id returns 404", %{conn: conn} do
      conn = get(conn, "/api/v1/playlists/0")
      assert json_response(conn, 404)
    end

    test "valid id returns 200", %{conn: conn} do
      conn = get(conn, "/api/v1/playlists/1")
      assert json_response(conn, 200) == %{"playlist" => %{}}
    end
  end
end
