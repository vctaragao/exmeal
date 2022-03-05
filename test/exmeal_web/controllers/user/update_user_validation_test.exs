defmodule ExmealWeb.Controllers.User.UpdateUserValidationTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  setup_all do
    {:ok, params: Map.put_new(build(:user_params), :id, 1)}
  end

  describe "call/2" do
    test "When given invalid name for name returns an error", %{conn: conn, params: params} do
      data =
        %{params | name: "a"}
        |> call_route(conn)
        |> assert_response_with_reason("tamanho deve ser maior ou igual a 2")

      assert "name" == data["field"]
    end

    test "When given invalid cpf returns an error", %{conn: conn, params: params} do
      data =
        %{params | cpf: "12345678910"}
        |> call_route(conn)
        |> assert_response_with_reason("não corresponde ao formato")

      assert "cpf" == data["field"]
    end

    test "When given invalid email returns an error", %{conn: conn, params: params} do
      data =
        %{params | email: "emailinvalido.com"}
        |> call_route(conn)
        |> assert_response_with_reason("não corresponde ao formato")

      assert "email" == data["field"]
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
    patch(conn, Routes.update_user_path(conn, :index, params.id, params))
  end

  defp assert_response_with_reason(response, reason) do
    assert body = json_response(response, :bad_request)
    assert "Erro de validação" == body["message"]
    assert reason == body["data"]["error"]
    assert body["data"]["field"]
    body["data"]
  end
end
