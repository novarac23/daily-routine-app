defmodule DailyRoutine.Repo.Migrations.AddForeignKeyUsers do
  use Ecto.Migration

  def change do
    alter table(:routines) do
      add :user_id, references(:users, on_delete: :nothing)
    end

    create index(:routines, [:user_id])
  end
end
