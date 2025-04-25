defmodule ChatappNewWeb.ChatLive do
  use ChatappNewWeb, :live_view

  alias ChatappNew.Chat
  alias ChatappNew.Chat.{Channel, Message}
  alias ChatappNew.Users.User
  alias Pow.Plug.CurrentUser

  @impl true
  def mount(_params, session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(ChatappNew.PubSub, "chat:lobby")
    user = case session["pow_user"] do
      nil -> nil
      user_id -> ChatappNew.Repo.get(ChatappNew.Users.User, user_id)
    end
    channels = Chat.list_channel()
    messages = Chat.list_messages()
    {:ok,
     assign(socket,
       user: user,
       channels: channels,
       messages: messages,
       current_channel: nil,
       message: "",
       typing_users: %{}
     )}
  end

  @impl true
  def handle_event("send_message", %{"message" => body}, socket) do
    user = socket.assigns.user
    channel = socket.assigns.current_channel
    if user && channel do
      {:ok, message} = Chat.create_message(%{
        body: body,
        user_id: user.id,
        channel_id: channel.id
      })
      Phoenix.PubSub.broadcast(ChatappNew.PubSub, "chat:lobby", {:new_message, message})
    end
    {:noreply, assign(socket, message: "")}
  end

  @impl true
  def handle_info({:new_message, message}, socket) do
    {:noreply, update(socket, :messages, fn msgs -> msgs ++ [message] end)}
  end

  @impl true
  def handle_event("select_channel", %{"id" => id}, socket) do
    channel = Chat.get_channel!(id)
    messages = Chat.list_messages_for_channel(channel.id)
    {:noreply, assign(socket, current_channel: channel, messages: messages)}
  end

  @impl true
  def handle_event("typing", _params, socket) do
    user = socket.assigns.user
    Phoenix.PubSub.broadcast(ChatappNew.PubSub, "chat:lobby", {:typing, user.id})
    {:noreply, socket}
  end

  @impl true
  def handle_info({:typing, user_id}, socket) do
    typing_users = Map.put(socket.assigns.typing_users, user_id, true)
    {:noreply, assign(socket, typing_users: typing_users)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex h-screen">
      <aside class="w-1/4 bg-gray-800 text-white p-4">
        <h2 class="font-bold text-lg mb-4">Channels</h2>
        <ul>
          <%= for channel <- @channels do %>
            <li>
              <button phx-click="select_channel" phx-value-id={channel.id} class={if @current_channel && @current_channel.id == channel.id, do: "font-bold", else: ""}>
                <%= channel.name %>
              </button>
            </li>
          <% end %>
        </ul>
      </aside>
      <main class="flex-1 flex flex-col">
        <section class="flex-1 overflow-y-auto p-4">
          <h3 class="font-bold text-xl mb-2">
            <%= if @current_channel, do: @current_channel.name, else: "Select a channel" %>
          </h3>
          <div id="messages">
            <%= for msg <- @messages do %>
              <div class="mb-2">
                <span class="font-semibold"><%= msg.user_id %>:</span>
                <%= msg.body %>
              </div>
            <% end %>
          </div>
        </section>
        <form phx-submit="send_message" class="p-4 flex gap-2">
          <input type="text" name="message" value={@message} phx-change="typing" placeholder="Type a message..." class="flex-1 border rounded px-2" />
          <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">Send</button>
        </form>
        <div class="p-2 text-sm text-gray-600">
          <%= for {user_id, _} <- @typing_users do %>
            <span><%= user_id %> is typing...</span>
          <% end %>
        </div>
      </main>
    </div>
    """
  end
end
