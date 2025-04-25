defmodule ChatappNew.ChatMessageTest do
  use ChatappNew.DataCase, async: true

  alias ChatappNew.Chat
  alias ChatappNew.Chat.Message
  alias ChatappNew.Users.User

  describe "messages" do
    setup do
      {:ok, user} = ChatappNew.Repo.insert(%User{email: "user@example.com", password_hash: "hash"})
      {:ok, channel} = Chat.create_channels(%{name: "random", description: "Random", is_private: false})
      {:ok, user: user, channel: channel}
    end

    test "create and list messages", %{user: user, channel: channel} do
      {:ok, message} = Chat.create_message(%{body: "Hello!", user_id: user.id, channel_id: channel.id})
      messages = Chat.list_messages()
      assert Enum.any?(messages, fn m -> m.id == message.id end)
    end

    test "list messages for channel", %{user: user, channel: channel} do
      {:ok, message} = Chat.create_message(%{body: "Channel msg", user_id: user.id, channel_id: channel.id})
      messages = Chat.list_messages_for_channel(channel.id)
      assert Enum.any?(messages, fn m -> m.id == message.id end)
    end
  end
end
