defmodule Exmeal.UserTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.User

  setup_all do
    {:ok, params: build(:user_params)}
  end

  describe "changeset/1" do
    test "When given valid params create a valid changeset", %{params: params} do
      {:ok, changeset} = User.changeset(params)

      assert changeset.valid?
      assert changeset.errors == []
    end

    test "When given an invalid name returns an error", %{params: params} do
      result = User.changeset(%{params | name: ""})

      assert {:error, [info: %{field: "name", reason: "can't be blank"}]} = result
    end

    test "When given a name with invalid length returns an error", %{params: params} do
      result = User.changeset(%{params | name: "a"})

      assert {:error, [info: %{field: "name", reason: "should be at least 2 character(s)"}]} =
               result
    end

    test "When given an invalid cpf returns an error", %{params: params} do
      result = User.changeset(%{params | cpf: ""})

      assert {:error, [info: %{field: "cpf", reason: "can't be blank"}]} = result
    end

    test "When given a cpf with wrong format returns an error", %{params: params} do
      result = User.changeset(%{params | cpf: "123"})

      assert {:error, [info: %{field: "cpf", reason: "has invalid format"}]} = result
    end

    test "When given a invalid email returns an error", %{params: params} do
      result = User.changeset(%{params | email: ""})

      assert {:error, [info: %{field: "email", reason: "can't be blank"}]} = result
    end

    test "When given a email with wrong format returns an error", %{params: params} do
      result = User.changeset(%{params | email: "123"})

      assert {:error, [info: %{field: "email", reason: "has invalid format"}]} = result
    end
  end
end
