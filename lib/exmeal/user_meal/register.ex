defmodule Exmeal.UserMeal.Register do
  alias Exmeal.Repo
  alias Exmeal.Meal
  alias Exmeal.User

  def call(%{user_id: id, meals: [%{description: _, date: _, calories: _} | _] = meals})
      when is_integer(id) do
    case Repo.get(User, id) do
      nil -> {:error, "Can't insert meals to user", reason: "invalid Id"}
      user -> register_user_meals(user, meals)
    end
  end

  def call(_), do: {:error, "Can't insert meals to user", reason: "invalid params"}

  defp register_user_meals(user, meals) do
    with {:ok, meals} <- validate_meals(meals),
         {:ok, message} <- register_meals(user, meals) do
      {:ok, message}
    end
  end

  defp validate_meals(meals) do
    meals
    |> Enum.map(fn meal ->
      case Meal.changeset(meal) do
        {:error, _} -> nil
        {:ok, changeset} -> changeset
      end
    end)
    |> Enum.filter(&(!!&1))
    |> check_for_invalid_meals(meals)
  end

  defp check_for_invalid_meals(filtered_meals, meals) do
    if Enum.count(filtered_meals) !== Enum.count(meals),
      do: {:error, "Can't insert meals to user", reason: "invalid meal format"},
      else: {:ok, meals}
  end

  defp register_meals(user, meals) do
    meals
    |> Enum.map(&User.build_meal_assoc(&1, user))
    |> Meal.build_user_meals_multi()
    |> Repo.transaction()
    |> handle_transaction_result()
  end

  defp handle_transaction_result({:ok, _}), do: {:ok, "Meals registered succefully"}

  defp handle_transaction_result({:error, failed_operation, failed_value, changes_so_far}) do
    {
      :error,
      "Can't register user meals",
      reason: %{
        failed_operation: failed_operation,
        failed_value: failed_value,
        changes_so_far: changes_so_far
      }
    }
  end
end
