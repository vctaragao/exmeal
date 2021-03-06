defmodule Exmeal.Meal.CreateTest do
  use Exmeal.DataCase, async: true

  alias Exmeal.Meal.Create
  alias Exmeal.Meal

  setup_all do
    params = build(:meal_params)

    {:ok, params: params}
  end

  describe "call/1" do
    test "When given valid params create a valid meal record", setup do
      assert {:ok, %Meal{}} = Create.call(setup[:params])
    end

    test "When given invalid params value create a valid meal record", setup do
      params = %{setup[:params] | description: 123}

      response = Create.call(params)

      assert {:error, "Can't register meal",
              [reason: [info: %{field: "description", reason: "is invalid"}]]} == response
    end

    test "When given invalid params key create a valid meal record", setup do
      params =
        setup[:params]
        |> Map.delete(:description)
        |> Map.put(:desc, "description")

      response = Create.call(params)

      assert {:error, "Can't register meal", [reason: "invalid params"]} == response
    end
  end
end
