defmodule Exmeal.User do
  use Exmeal, :schema

  @fields [:name, :cpf, :email]

  schema "user" do
    field :name, :string
    field :cpf, :string
    field :email, :string

    timestamps()

    has_many :meals, Exmeal.Meal
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:name, min: 2)
    |> validate_format(:cpf, ~r/\d{3}\.\d{3}\.\d{3}\-\d{2}/)
    |> handle_changeset()
  end

  def build_meal_assoc(meal_params, user), do: Ecto.build_assoc(user, :meals, meal_params)
end
