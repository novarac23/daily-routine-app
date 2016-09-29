defmodule DailyRoutine.Routine do
  use DailyRoutine.Web, :model

  schema "routines" do
    field :title, :string
    field :timeframe, :integer
    field :content, :string

    timestamps
  end

  @required_fields ~w(title timeframe content)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
