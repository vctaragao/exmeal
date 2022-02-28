defmodule Exmeal.Meal.GetTest do
  use Exmeal.DataCase, async: true

  alias Exmeal.Meal.Get
  alias Exmeal.Repo

  describe "call/1" do
    test "When given a valid id returns a meal" do
      {:ok, expected_meal} = build(:meal) |> Repo.insert()

      assert {:ok, meal} = Get.call(%{id: expected_meal.id})

      assert expected_meal == meal
    end

    test "When given an invalid id returns empty" do
      {:ok, expected_meal} = build(:meal) |> Repo.insert()

      assert {:ok, %{}} = Get.call(%{id: expected_meal.id + 1})
    end

    test "When given an invalid id param returns an error" do
      build(:meal) |> Repo.insert()

      assert {:error, "Invalid params"} = Get.call(%{id: "string"})
    end
  end
end
