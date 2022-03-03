defmodule Exmeal.User.Update do
  alias Exmeal.Repo
  alias Exmeal.User

  def call(%{id: _, name: _, cpf: _, email: _} = params) do
    case Repo.get(User, params[:id]) do
      nil -> {:error, "Can't update user", reason: "invalid Id"}
      user -> update(user, params)
    end
  end

  def call(_), do: {:error, "Can't update user", reason: "invalid params"}

  defp update(user, params) do
    with {:ok, changeset} <- User.changeset(user, params),
         {:ok, user} <- Repo.update(changeset) do
      {:ok, user}
    else
      {:error, reason} -> {:error, "Can't update user", reason: reason}
    end
  end
end
