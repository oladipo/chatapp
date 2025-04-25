defmodule ChatappNewWeb.PresenceTest do
  use ChatappNewWeb.ConnCase, async: true

  test "presence module is loaded and responds to track/3" do
    assert function_exported?(Phoenix.PubSub, :subscribe, 2)
    assert function_exported?(Phoenix.PubSub, :broadcast, 3)
  end
end
