defmodule ChatappNewWeb.ChatLiveTest do
  use ChatappNewWeb.ConnCase
  import Phoenix.LiveViewTest
  import ChatappNew.ChatFixtures
  alias ChatappNew.Chat
  alias ChatappNew.Users.User

  setup do
    {:ok, user} = ChatappNew.Repo.insert(%User{email: "testuser@example.com", password_hash: "hash"})
    {:ok, channel} = Chat.create_channels(%{name: "test", description: "Test channel", is_private: false})
    {:ok, user: user, channel: channel}
  end

  test "renders chat page and lists channels", %{conn: conn, channel: channel} do
    {:ok, _view, html} = live(conn, "/")
    assert html =~ channel.name
  end

  test "sending a message updates the chat", %{conn: conn, user: user, channel: channel} do
    {:ok, view, _html} = live(conn, "/")
    # Simulate selecting a channel
    send(view.pid, {:new_message, %{body: "Hello world!", user_id: user.id, channel_id: channel.id}})
    assert render(view) =~ "Hello world!"
  end

  test "shows typing indicator when user is typing", %{conn: conn, user: user, channel: channel} do
    {:ok, view, _html} = live(conn, "/")
    send(view.pid, {:typing, user.id})
    assert render(view) =~ "typing"
  end
end
