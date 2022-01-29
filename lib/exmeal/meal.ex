defmodule Exmeal.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  @fields [:description, :date, :calories]

  schema "meals" do
    field :description, :string
    field :date, :utc_datetime
    field :calories, :float
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
