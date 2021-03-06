defmodule ExmealWeb.Controllers.User.DeleteUserValidationTest do
  use ExmealWeb.ConnCase, async: true

  @params %{
    id: "string"
  }

  describe "call/2" do
    test "When given invalid id returns an error", %{conn: conn} do
      data =
        @params[:id]
        |> call_route(conn)
        |> assert_response_with_reason("não é valido")

      assert "id" == data["field"]
    end
  end

  defp call_route(params, conn),
    do: delete(conn, Routes.delete_user_path(conn, :index, params))

  defp assert_response_with_reason(response, reason) do
    assert body = json_response(response, :bad_request)
    assert "Erro de validação" == body["message"]
    assert reason == body["data"]["error"]
    assert body["data"]["field"]
    body["data"]
  end
end
