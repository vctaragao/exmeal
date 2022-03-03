defmodule ExmealWeb.Controllers.Meal.DeleteMealValidationTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.Repo
  alias Exmeal.Meal

  describe "call/2" do
    test "When given valid params return a Meal", %{conn: conn} do
      {:ok, %Meal{id: id}} = build(:meal) |> Repo.insert()

      response = delete(conn, Routes.delete_meal_path(conn, :index, id))

      assert body = json_response(response, :no_content)

      assert %{"message" => "Refeição removida com sucesso", "data" => %{}} = body
    end

    test "When given an invalid id returns an error", %{conn: conn} do
      {:ok, %Meal{id: id}} = build(:meal) |> Repo.insert()

      response = delete(conn, Routes.delete_meal_path(conn, :index, id + 1))

      assert body = json_response(response, :bad_request)

      assert %{
               "data" => %{"error" => "Invalid", "field" => "id"},
               "message" => "Can't remove meal"
             } = body
    end
  end
end
