defmodule ExmealWeb.Controllers.UserMeal.CreateUserMealTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.Repo

  setup do
    {:ok, user} = build(:user) |> Repo.insert()
    params = %{build(:user_meal_params) | user_id: user.id}
    {:ok, params: %{params | meals: Jason.encode!(params[:meals])}}
  end

  describe "call/2" do
    test "When given valid params return success", %{conn: conn, params: params} do
      response = post(conn, Routes.create_user_meal_path(conn, :index, params))

      assert body = json_response(response, :no_content)

      assert "Refeições registradas com sucesso" == body["message"]
    end
  end
end
