defmodule Exmeal.Meal.Update do
  alias Ecto.Changeset
  alias Exmeal.Repo
  alias Exmeal.Meal

  def call(%{id: _, description: _, calories: _, date: _} = params) do
    case Repo.get(Meal, params[:id]) do
      nil -> {:error, "Can't update meal", reason: "invalid Id"}
      meal -> update(meal, params)
    end
  end

  def call(_) do
    {:error, "Can't update meal", reason: "invalid params"}
  end

  defp update(meal, params) do
    meal
    |> Meal.changeset(params)
    |> update_record(params)
    |> return_record()
  end

  defp update_record({:error, reason}, _), do: {:error, reason}

  defp update_record({:ok, %Changeset{} = changeset}, %{} = params) do
    Repo.update(changeset, Map.to_list(params))
  end

  defp return_record({:error, reason}), do: {:error, "Can't update meal", reason: reason}
  defp return_record({:ok, %Meal{} = meal}), do: {:ok, meal}
end
