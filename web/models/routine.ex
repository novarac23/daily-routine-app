defmodule DailyRoutine.Routine do
  use DailyRoutine.Web, :model

  schema "routines" do
    field :title, :string
    field :timeframe, :integer
    field :content, :string
    belongs_to :user, DailyRoutine.User
    has_many :comments, DailyRoutine.Comment

    timestamps
  end

  @required_fields ~w(title timeframe content)
  @optional_fields ~w()

  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
