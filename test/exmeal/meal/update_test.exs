defmodule Exmeal.Meal.UpdateTest do
  use Exmeal.DataCase, asyn: true

  import Exmeal.Factory

  alias Exmeal.Meal.Update
  alias Exmeal.Repo

  setup do
    {:ok, meal} = build(:meal) |> Repo.insert()
    {:ok, meal: meal}
  end

  describe "call/1" do
    test "when given valid parameters update record", setup do
      meal_updated = %{setup[:meal] | description: "atualizada"}

      assert {:ok, meal_result} =
               Update.call(%{
                 id: meal_updated.id,
                 description: meal_updated.description,
                 calories: meal_updated.calories,
                 date: meal_updated.date
               })

      assert meal_updated.id == meal_result.id
      assert meal_updated.description == meal_result.description
      assert meal_updated.calories == meal_result.calories
      assert meal_updated.date == meal_result.date
    end

    test "When given invalid params returns an error", setup do
      meal = setup[:meal]

      result = Update.call(%{id: meal.id, description: meal.description, calories: meal.calories})

      assert {:error, "Can't update meal", [reason: "invalid params"]} = result
    end

    test "When given invalid id returns an error", setup do
      meal = setup[:meal]

      result =
        Update.call(%{
          id: meal.id + 1,
          description: meal.description,
          calories: meal.calories,
          date: meal.date
        })

      assert {:error, "Can't update meal", [reason: "invalid Id"]} = result
    end
  end
end
