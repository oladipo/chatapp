defmodule ChatappNewWeb.ChannelTest do
  use ChatappNewWeb.ConnCase, async: true
  alias ChatappNew.Chat

  test "create public and private channels" do
    {:ok, public} = Chat.create_channels(%{name: "public", description: "Public channel", is_private: false})
    {:ok, private} = Chat.create_channels(%{name: "private", description: "Private channel", is_private: true})
    assert public.is_private == false
    assert private.is_private == true
    channels = Chat.list_channel()
    assert Enum.any?(channels, fn c -> c.name == "public" end)
    assert Enum.any?(channels, fn c -> c.name == "private" end)
  end

  test "cannot create channel with missing name" do
    {:error, changeset} = Chat.create_channels(%{description: "No name", is_private: false})
    refute changeset.valid?
  end
end
