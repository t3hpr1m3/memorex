defmodule MemorexPlaylists.YouTube.CacheTest do
  use ExUnit.Case

  test "stores and retrieves a value" do
    MemorexPlaylists.YouTube.Cache.put("test", "val")
    assert {:ok, "val"} == MemorexPlaylists.YouTube.Cache.get("test")
  end
end
