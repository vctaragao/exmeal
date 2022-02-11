defmodule Exmeal.CreateMeal do
  alias Ecto.Changeset
  alias Exmeal.Repo
  alias Exmeal.Meal

  def call(%{description: _, date: _, calories: _} = params) do
    params
    |> Meal.changeset()
    |> insert_record()
    |> return_record()
  end

  def call(_) do
    {:error, "Can't register meal", reason: "invalid params"}
  end

  defp insert_record({:error, reason}), do: {:error, reason}
  defp insert_record({:ok, %Changeset{} = changeset}), do: Repo.insert(changeset)

  defp return_record({:error, reason}), do: {:error, "Can't register meal", reason: reason}
  defp return_record({:ok, %Meal{} = meal}), do: {:ok, meal}
end
