defmodule ExmealWeb.CreateMealControllerTest do
  use ExmealWeb.ConnCase

  @params %{
    description: "descrição",
    date: "28/01/2022",
    hour: "10",
    minute: "10",
    calories: 100
  }

  describe "call/2" do
    test "When given valid params return a Meal id", %{conn: conn} do
      response = post(conn, Routes.create_meal_path(conn, :index, @params))

      assert body = json_response(response, :created)

      assert "Refeição criada com sucesso" == body["message"]
      assert meal_id = body["data"]["meal_id"]
      assert is_integer(meal_id)
    end
  end
end
