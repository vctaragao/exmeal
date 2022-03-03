defmodule Exmeal.User.Create do
  alias Ecto.Changeset
  alias Exmeal.User
  alias Exmeal.Repo

  def call(%{name: _, cpf: _, email: _} = params) do
    with {:ok, %Changeset{} = changeset} <- User.changeset(params),
         {:ok, %User{} = user} <- Repo.insert(changeset) do
      {:ok, user}
    else
      {:error, reason} -> {:error, "Can't register user", reason: reason}
    end
  end

  def call(_), do: {:error, "Can't register user", reason: "invalid params"}
end
