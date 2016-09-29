defmodule DailyRoutine.Repo.Migrations.CreateRoutine do
  use Ecto.Migration

  def change do
    create table(:routines) do
      add :title, :string, null: false
      add :timeframe, :integer, null: false
      add :content, :text, null: false

      timestamps
    end
  end
end
