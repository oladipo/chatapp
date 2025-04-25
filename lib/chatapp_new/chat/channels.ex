defmodule ChatappNew.Chat.Channels do
  use Ecto.Schema
  import Ecto.Changeset

  schema "channel" do
    field :name, :string
    field :description, :string
    field :is_private, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(channels, attrs) do
    channels
    |> cast(attrs, [:name, :description, :is_private])
    |> validate_required([:name, :description, :is_private])
  end
end
