defmodule DailyRoutine.Comment do
  use DailyRoutine.Web, :model

  schema "comments" do
    field :content, :string
    belongs_to :user, DailyRoutine.User
    belongs_to :routine, DailyRoutine.Routine

    timestamps
  end

  @required_fields ~w(user_id routine_id content)
  @optional_fields ~w()

  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def query_comments(query, routine_id) do
    from c in query,
    where: c.routine_id == ^routine_id,
    preload: :user
  end
end
