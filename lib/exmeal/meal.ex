defmodule Exmeal.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

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

  defp handle_changeset(%Changeset{} = changeset) do
    if changeset.valid?, do: {:ok, changeset}, else: handle_error(changeset.errors)
  end

  defp handle_error([{field, {reason, _}} | _]) do
    {:error, info: %{field: Atom.to_string(field), reason: reason}}
  end
end
