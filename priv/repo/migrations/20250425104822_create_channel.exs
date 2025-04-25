defmodule ChatappNew.Repo.Migrations.CreateChannel do
  use Ecto.Migration

  def change do
    create table(:channel) do
      add :name, :string
      add :description, :string
      add :is_private, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
