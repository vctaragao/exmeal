defmodule ExmealWeb.Controllers.User.CreateUserTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  setup_all do
    {:ok, params: build(:user_params)}
  end

  describe "call/2" do
    test "When given valid params return a User id", %{conn: conn, params: params} do
      response = post(conn, Routes.create_user_path(conn, :index, params))

      assert body = json_response(response, :created)

      assert "Usuário criado com sucesso" == body["message"]
      assert user_id = body["data"]["user_id"]
      assert is_integer(user_id)
    end
  end
end
