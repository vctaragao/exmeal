defmodule Exmeal.Meal.DeleteTest do
  use Exmeal.DataCase, async: true

  alias Exmeal.Meal.Delete
  alias Exmeal.Repo

  describe "call/1" do
    test "When given a valid id removes a meal" do
      {:ok, expected_meal} = build(:meal) |> Repo.insert()

      assert {:ok, meal} = Delete.call(%{id: expected_meal.id})

      assert expected_meal.id == meal.id
    end

    test "When given an invalid id returns empty" do
      {:ok, expected_meal} = build(:meal) |> Repo.insert()

      assert {:error, "Can't remove meal", %{domain: "domain", reason: {"id", "Invalid"}}} =
               Delete.call(%{id: expected_meal.id + 1})
    end

    test "When given an invalid id param returns an error" do
      build(:meal) |> Repo.insert()

      assert {:error, "Invalid params"} = Delete.call(%{id: "string"})
    end
  end
end
