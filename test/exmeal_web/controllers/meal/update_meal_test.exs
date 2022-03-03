defmodule ExmealWeb.Controllers.Meal.UpdateMealTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.Repo

  setup [:build_params_and_seed]

  defp build_params_and_seed(_) do
    {:ok, meal} = build(:meal) |> Repo.insert()

    %{params: Map.put_new(build(:meal_action_params), :id, meal.id)}
  end

  describe "call/2" do
    test "When given valid params return a Meal id", %{conn: conn, params: params} do
      response = patch(conn, Routes.update_meal_path(conn, :index, params.id), params)

      assert body = json_response(response, :ok)

      assert "Refeição atualizada com sucesso" == body["message"]
      assert meal_id = body["data"]["meal_id"]
      assert is_integer(meal_id)
    end
  end
end
