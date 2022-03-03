defmodule Exmeal.Meal do
  use Exmeal, :schema

  @fields [:description, :date, :calories]

  @derive Jason.Encoder

  schema "meal" do
    field :description, :string
    field :date, :utc_datetime
    field :calories, :float

    timestamps()
  end

  def changeset(meal \\ %__MODULE__{}, params) do
    meal
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> handle_changeset()
  end
end
