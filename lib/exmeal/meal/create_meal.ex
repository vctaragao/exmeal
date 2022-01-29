defmodule Exmeal.Meal.CreateMeal do
  import Exmeal.Helper.Date

  alias Ecto.Changeset
  alias Exmeal.Repo
  alias Exmeal.Meal

  def call(%{date: date, hour: hour, minute: minute} = params) do
    with {:ok, datetime, _} <- format_datetime(date, hour, minute) do
      %{params | date: datetime}
      |> create_changeset()
      |> insert_record()
      |> return_record_id()
    end
  end

  defp create_changeset(params), do: Meal.changeset(params)

  defp insert_record({:ok, %Changeset{} = changeset}), do: Repo.insert(changeset)
  defp insert_record({:error, reason}), do: {:error, reason}

  defp return_record_id({:ok, %Meal{id: id}}), do: id

  defp return_record_id({:error, reason}) do
    {:error, "Não foi possível criar refeição: campo #{reason}"}
  end
end
