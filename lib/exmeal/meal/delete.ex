defmodule Exmeal.Meal.Delete do
  alias Exmeal.Repo
  alias Exmeal.Meal

  def call(%{id: id}) when is_integer(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, "Can't remove meal", %{reason: {"id", "Invalid"}, domain: "domain"}}
      meal -> Repo.delete(meal) |> handle_result()
    end
  end

  def call(_), do: {:error, "Invalid params"}

  defp handle_result({:ok, %Meal{} = meal}), do: {:ok, meal}

  defp handle_result({:error, reason}),
    do: {:error, "Can't remove meal", %{reason: reason, domain: "domain"}}
end
