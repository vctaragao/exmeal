defmodule ExmealWeb.UpdateMealControllerValidationTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  setup [:build_params]

  defp build_params(_), do: %{params: Map.put_new(build(:meal_action_params), :id, 1)}

  describe "call/2" do
    test "When given invalid date returns an error", %{conn: conn, params: params} do
      data =
        %{params | date: "28-01/2022"}
        |> call_route(conn)
        |> assert_response_with_reason("não corresponde ao formato")

      assert "date" == data["field"]
    end

    test "When given invalid hour returns an error", %{conn: conn, params: params} do
      data =
        %{params | hour: "string"}
        |> call_route(conn)
        |> assert_response_with_reason("não é valido")

      assert "hour" == data["field"]
    end

    test "When given invalid minutes returns an error", %{conn: conn, params: params} do
      data =
        %{params | minute: "string"}
        |> call_route(conn)
        |> assert_response_with_reason("não é valido")

      assert "minute" == data["field"]
    end

    test "When given invalid calories returns an error", %{conn: conn, params: params} do
      data =
        %{params | calories: "string"}
        |> call_route(conn)
        |> assert_response_with_reason("não é valido")

      assert "calories" == data["field"]
    end

    test "When given hour below min value returns an error", %{conn: conn, params: params} do
      data =
        %{params | hour: -1}
        |> call_route(conn)
        |> assert_response_with_reason("deve ser maior ou igual a 0")

      assert "hour" == data["field"]
    end

    test "When given hour higher than max value returns an error", %{conn: conn, params: params} do
      data =
        %{params | hour: 24}
        |> call_route(conn)
        |> assert_response_with_reason("deve ser menor ou igual a 23")

      assert "hour" == data["field"]
    end

    test "When given minute higher than max value returns an error", %{conn: conn, params: params} do
      data =
        %{params | minute: 60}
        |> call_route(conn)
        |> assert_response_with_reason("deve ser menor ou igual a 59")

      assert "minute" == data["field"]
    end

    test "When given minute lower than min value returns an error", %{conn: conn, params: params} do
      data =
        %{params | minute: -1}
        |> call_route(conn)
        |> assert_response_with_reason("deve ser maior ou igual a 0")

      assert "minute" == data["field"]
    end

    test "When given invalid id returns an error", %{conn: conn, params: params} do
      data =
        %{params | id: "string"}
        |> call_route(conn)
        |> assert_response_with_reason("não é valido")

      assert "id" == data["field"]
    end
  end

  defp call_route(params, conn) do
    patch(conn, Routes.update_meal_path(conn, :index, params.id, params))
  end

  defp assert_response_with_reason(response, reason) do
    assert body = json_response(response, :bad_request)
    assert "Erro de validação" == body["message"]
    assert reason == body["data"]["error"]
    assert body["data"]["field"]
    body["data"]
  end
end
