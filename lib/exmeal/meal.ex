defmodule Exmeal.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  @fields [:description, :date, :calories]

  schema "meals" do
    field :description, :string
    field :date, :datetime
    field :calories, :float
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_format(:date, ~r/\d{4}-\d{2}-\d{2}/)
  end
end
