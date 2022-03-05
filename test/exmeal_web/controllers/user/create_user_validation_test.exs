defmodule ExmealWeb.Controllers.User.CreateUserValidationTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  setup_all do
    {:ok, params: build(:user_params)}
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
  end

  defp call_route(params, conn), do: post(conn, Routes.create_user_path(conn, :index), params)

  defp assert_response_with_reason(response, reason) do
    assert body = json_response(response, :bad_request)
    assert "Erro de validação" == body["message"]
    assert error_reason = body["data"]["error"]
    assert reason == error_reason
    assert body["data"]["field"]
    body["data"]
  end
end
