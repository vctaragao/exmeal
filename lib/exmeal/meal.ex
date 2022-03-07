defmodule Exmeal.Meal do
  use Exmeal, :schema

  alias Ecto.Multi

  @fields [:description, :date, :calories]

  @derive Jason.Encoder

  schema "meal" do
    field :description, :string
    field :date, :utc_datetime
    field :calories, :float

    timestamps()

    belongs_to :user, Exmeal.User
  end

  def changeset(meal \\ %__MODULE__{}, params) do
    meal
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> handle_changeset()
  end

  def build_user_meals_multi(meals) do
    Enum.reduce(meals, Multi.new(), fn meal, multi ->
      Multi.insert(multi, meal.description, meal)
    end)
  end
end
