defmodule ChatappNew.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    belongs_to :user, ChatappNew.Users.User
    belongs_to :channel, ChatappNew.Chat.Channels
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :user_id, :channel_id])
    |> validate_required([:body, :user_id, :channel_id])
  end
end
