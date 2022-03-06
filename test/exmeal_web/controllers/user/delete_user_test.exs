defmodule ExmealWeb.Controllers.User.DeleteUserTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.Repo

  setup do
    {:ok, user} = build(:user) |> Repo.insert()
    {:ok, user: user}
  end

  describe "call/2" do
    test "When given valid params return empty", %{conn: conn, user: user} do
      response = delete(conn, Routes.delete_user_path(conn, :index, user.id))

      assert body = json_response(response, :no_content)

      assert %{"message" => "Usuário removido com sucesso", "data" => %{}} = body
    end

    test "When given an invalid id returns an error", %{conn: conn, user: user} do
      response = delete(conn, Routes.delete_user_path(conn, :index, user.id + 1))

      assert body = json_response(response, :bad_request)

      assert %{
               "data" => %{"error" => "Id inválido"},
               "message" => "Não foi possível remover usuário"
             } = body
    end
  end
end
