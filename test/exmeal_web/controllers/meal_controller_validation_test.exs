defmodule ExmealWeb.MealControllerValidationTest do
  use ExmealWeb.ConnCase

  @params %{
    description: "descrição",
    date: "28/01/2022",
    hour: "10",
    minute: "10",
    calories: 100
  }

  describe "call/2" do
    test "When given invalid params returns an error", %{conn: conn} do
      response = post(conn, Routes.meal_path(conn, :create, %{@params | date: "28-01/2022"}))

      assert body = json_response(response, :bad_request)
      assert "Erro de validação" == body["message"]
      assert error_reason = body["data"]["error"]
      assert "não corresponde ao formato" == error_reason
      assert field = body["data"]["field"]
      assert "date" == field
    end
  end
end
