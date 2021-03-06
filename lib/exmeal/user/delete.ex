defmodule Exmeal.User.Delete do
  alias Exmeal.Repo
  alias Exmeal.User

  def call(%{id: id}) when is_integer(id) do
    case Repo.get(User, id) do
      nil -> {:error, "Can't remove user", reason: "invalid Id"}
      meal -> Repo.delete(meal) |> handle_result()
    end
  end

  def call(_), do: {:error, "Can't remove user", reason: "Invalid params"}

  defp handle_result({:ok, user}), do: {:ok, user}
  defp handle_result({:error, reason}), do: {:error, "Can't remove user", reason: reason}
end
