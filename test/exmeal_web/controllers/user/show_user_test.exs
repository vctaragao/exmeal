defmodule ExmealWeb.Controllers.User.ShowUserTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.Repo

  setup do
    {:ok, user} = build(:user) |> Repo.insert()

    {:ok, expected_user: user}
  end

  describe "call/2" do
    test "When given valid params return a User", %{conn: conn, expected_user: expected_user} do
      response = get(conn, Routes.show_user_path(conn, :index, expected_user.id))

      assert body = json_response(response, :ok)

      assert %{"message" => "Usuário retornado com sucesso", "data" => data} = body

      assert expected_user.id == data["id"]
      assert expected_user.name == data["name"]
      assert expected_user.cpf == data["cpf"]
      assert expected_user.email == data["email"]
    end

    test "When given an invalid id returns empty", %{conn: conn, expected_user: %{id: id}} do
      response = get(conn, Routes.show_user_path(conn, :index, id + 1))

      assert body = json_response(response, :ok)

      assert %{"message" => "Usuário retornado com sucesso", "data" => %{}} = body
    end
  end
end
