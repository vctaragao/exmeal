defmodule Exmeal.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @fields [:description, :date, :calories]

  schema "meal" do
    field :description, :string
    field :date, :utc_datetime
    field :calories, :float

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> handle_changeset()
  end

  defp handle_changeset(%Changeset{} = changeset) do
    if changeset.valid? do
      {:ok, changeset}
    else
      handle_changeset_error(changeset.errors)
    end
  end

  defp handle_changeset_error([{field, {reason, _}} | _]) do
    {:error, "#{Atom.to_string(field)} #{reason}"}
  end
end
