defmodule Exmeal.MealTest do
  use Exmeal.DataCase

  alias Exmeal.Meal

  setup_all do
    params = %{description: "descrição", date: DateTime.utc_now(), calories: 100.50}
    {:ok, params: params}
  end

  describe "changeset/1" do
    test "When given valid params create a valid meal changeset from schema", setup do
      {:ok, changeset} = Meal.changeset(setup[:params])

      assert changeset.valid?
      assert changeset.errors == []
    end

    test "When given an invalid date returns an error", setup do
      params = %{setup[:params] | date: "10/10/2022"}

      assert {:error, "date is invalid"} = Meal.changeset(params)
    end

    test "When given an invalid description returns an error", setup do
      params = %{setup[:params] | description: 123.4}

      assert {:error, "description is invalid"} = Meal.changeset(params)
    end

    test "When given an invalid calories returns an error", setup do
      params = %{setup[:params] | calories: "helllo"}

      assert {:error, "calories is invalid"} = Meal.changeset(params)
    end
  end
end
