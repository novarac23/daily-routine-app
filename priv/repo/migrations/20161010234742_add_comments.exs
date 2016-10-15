defmodule DailyRoutine.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :text, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :routine_id, references(:routines, on_delete: :nothing)

      timestamps
    end

    create index(:comments, [:user_id])
    create index(:comments, [:routine_id])
  end
end
