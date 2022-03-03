defmodule ExmealWeb.Controllers.Meal.ShowMealTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.Repo
  alias Exmeal.Meal

  describe "call/2" do
    test "When given valid params return a Meal", %{conn: conn} do
      {:ok, expected_meal} = build(:meal) |> Repo.insert()

      response = get(conn, Routes.show_meal_path(conn, :index, expected_meal.id))

      assert body = json_response(response, :ok)

      assert %{"message" => "Refeição retornada com sucesso", "data" => data} = body

      assert expected_meal.id == data["id"]
      assert expected_meal.calories == data["calories"]
      assert DateTime.to_string(expected_meal.date) == data["date"]
      assert expected_meal.description == data["description"]
    end

    test "When given an invalid id returns an error", %{conn: conn} do
      {:ok, %Meal{id: id}} = build(:meal) |> Repo.insert()

      response = get(conn, Routes.show_meal_path(conn, :index, id + 1))

      assert body = json_response(response, :ok)

      assert %{"message" => "Refeição retornada com sucesso", "data" => %{}} = body
    end
  end
end
