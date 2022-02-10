defmodule Exmeal.Meal.GetMealTest do
  use Exmeal.DataCase, async: true

  alias Exmeal.GetMeal
  alias Exmeal.Repo

  describe "call/1" do
    test "When given a valid id returns a meal" do
      {:ok, expected_meal} = build(:meal) |> Repo.insert()

      assert {:ok, meal} = GetMeal.call(%{id: expected_meal.id})

      assert expected_meal == meal
    end
  end
end
