defmodule ExmealWeb.Controllers.User.UpdateUserTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.Repo

  setup [:build_params_and_seed]

  defp build_params_and_seed(_) do
    {:ok, user} = build(:user) |> Repo.insert()

    %{params: Map.put_new(build(:user_params), :id, user.id)}
  end

  describe "call/2" do
    test "When given valid params return a User id", %{conn: conn, params: params} do
      response = patch(conn, Routes.update_user_path(conn, :index, params.id), params)
      assert body = json_response(response, :ok)

      assert "Usuário atualizado com sucesso" == body["message"]
      assert user_id = body["data"]["user_id"]
      assert is_integer(user_id)
    end

    test "When given an id that dosent exits returns an error", %{conn: conn, params: p} do
      params = %{p | id: "#{p.id + 1}"}

      response = patch(conn, Routes.update_user_path(conn, :index, params.id), params)

      assert body = json_response(response, :bad_request)

      assert "Não foi possível atualizar usuário" == body["message"]
      assert "Id inválido" == body["data"]["error"]
    end
  end
end
