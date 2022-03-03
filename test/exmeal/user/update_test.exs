defmodule Exmeal.User.UpdateTest do
  use Exmeal.DataCase, asyn: true

  import Exmeal.Factory

  alias Exmeal.User.Update
  alias Exmeal.Repo

  setup do
    {:ok, user} = build(:user) |> Repo.insert()
    {:ok, expected_user: user}
  end

  describe "call/1" do
    test "when given valid parameters update record", %{expected_user: expected_user} do
      updated_user = %{expected_user | name: "Nome Atualizado"}

      assert {:ok, user} = build_params(updated_user) |> Update.call()

      assert updated_user.id == user.id
      assert updated_user.name == user.name
      assert updated_user.cpf == user.cpf
      assert updated_user.email == user.email
    end

    test "When given invalid params returns an error", %{expected_user: expected_user} do
      params = build_params(expected_user) |> Map.delete(:email)

      assert {:error, "Can't update user", [reason: "invalid params"]} = Update.call(params)
    end

    test "When given invalid id returns an error", %{expected_user: expected_user} do
      result =
        %{expected_user | id: expected_user.id + 1}
        |> build_params()
        |> Update.call()

      assert {:error, "Can't update user", [reason: "invalid Id"]} = result
    end

    defp build_params(user) do
      %{
        id: user.id,
        name: user.name,
        cpf: user.cpf,
        email: user.email
      }
    end
  end
end
