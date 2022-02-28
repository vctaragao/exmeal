defmodule ExmealWeb.Test.ExmealTest do
  use Exmeal.DataCase, async: true

  alias Exmeal.Meal.Create
  alias Exmeal.Meal

  setup_all do
    params = %{description: "descrição", date: DateTime.utc_now(), calories: 100.50}
    {:ok, params: params}
  end

  describe "create_meal/1" do
    test "Given a map o valid params receive a Meal", setup do
      assert {:ok, %Meal{}} = Create.call(setup[:params])
    end

    test "Given a map with invalid params receive an error", setup do
      params =
        setup[:params]
        |> Map.delete(:description)
        |> Map.put(:desc, "descrição")

      assert {:error, "Can't register meal", [reason: "invalid params"]} ==
               Create.call(params)
    end

    test "Giving not a map reacive an error", _setup do
      assert {:error, "Can't register meal", [reason: "invalid params"]} ==
               Create.call(
                 {:description, "descrição", :date, DateTime.utc_now(), :calories, 100.50}
               )
    end
  end
end
