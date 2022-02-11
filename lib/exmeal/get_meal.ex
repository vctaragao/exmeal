defmodule Exmeal.GetMeal do
  alias Exmeal.Repo
  alias Exmeal.Meal

  def call(%{id: id}) when is_integer(id), do: get_meal(id) |> handle_result()

  def call(_), do: {:error, "Invalid params"}

  defp get_meal(id), do: Repo.get(Meal, id)

  defp handle_result(%Meal{} = meal), do: {:ok, meal}
  defp handle_result(nil), do: {:ok, %{}}
end
