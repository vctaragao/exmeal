defmodule Exemal.User do
  use Exmeal, :schema

  @fields [:name, :cpf, :email]

  schema "users" do
    field :name, :string
    field :cpf, :string
    field :email, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> handle_changeset()
  end
end
