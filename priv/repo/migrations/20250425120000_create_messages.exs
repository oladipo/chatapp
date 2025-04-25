defmodule ChatappNew.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :text
      add :user_id, references(:users, on_delete: :delete_all)
      add :channel_id, references(:channel, on_delete: :delete_all)
      timestamps()
    end

    create index(:messages, [:user_id])
    create index(:messages, [:channel_id])
  end
end
