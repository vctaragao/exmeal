defmodule Exmeal.User do
  use Exmeal, :schema

  @fields [:name, :cpf, :email]

  schema "user" do
    field :name, :string
    field :cpf, :string
    field :email, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:name, min: 2)
    |> validate_format(:cpf, ~r/\d{3}\.\d{3}\.\d{3}\-\d{2}/)
    |> handle_changeset()
  end
end
