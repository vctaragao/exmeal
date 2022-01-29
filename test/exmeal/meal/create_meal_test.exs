defmodule Exmeal.Meal.CreateMealTest do
  use Exmeal.DataCase

  alias Exmeal.Meal.CreateMeal

  setup_all do
    params = %{
      description: "descrição",
      date: "28/01/1998",
      hour: "2",
      minute: "10",
      calories: 100.50
    }

    {:ok, params: params}
  end

  describe "call/1" do
    test "When given valid params create a valid meal record", setup do
      response = CreateMeal.call(setup[:params])

      assert is_integer(response)
    end

    test "When given invalid params value create a valid meal record", setup do
      params = %{setup[:params] | description: 123}

      response = CreateMeal.call(params)

      assert {:error, "Não foi possível criar refeição: campo description is invalid"} = response
    end

    test "When given invalid params key create a valid meal record", setup do
      params =
        setup[:params]
        |> Map.delete(:description)
        |> Map.put(:desc, "description")

      response = CreateMeal.call(params)

      assert {:error, "Não foi possível criar refeição: campo description can't be blank"} ==
               response
    end
  end
end
