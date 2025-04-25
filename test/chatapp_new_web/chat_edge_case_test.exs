defmodule ChatappNewWeb.ChatEdgeCaseTest do
  use ChatappNew.DataCase, async: true
  alias ChatappNew.Chat
  alias ChatappNew.Users.User

  setup do
    {:ok, user} = ChatappNew.Repo.insert(%User{email: "edge@example.com", password_hash: "hash"})
    {:ok, channel} = Chat.create_channels(%{name: "edge", description: "Edge channel", is_private: false})
    {:ok, user: user, channel: channel}
  end

  test "cannot send empty message", %{user: user, channel: channel} do
    {:error, changeset} = Chat.create_message(%{body: "", user_id: user.id, channel_id: channel.id})
    refute changeset.valid?
  end

  test "cannot send message with invalid user/channel", %{channel: channel} do
    {:error, changeset} = Chat.create_message(%{body: "bad user", user_id: -1, channel_id: channel.id})
    refute changeset.valid?
    {:error, changeset} = Chat.create_message(%{body: "bad channel", user_id: nil, channel_id: -1})
    refute changeset.valid?
  end
end
