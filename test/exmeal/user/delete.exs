defmodule Exmeal.User.DeleteTest do
  use Exmeal.DataCase, async: true

  alias Exmeal.User.Delete
  alias Exmeal.Repo

  setup do
    {:ok, user} = build(:user) |> Repo.insert()
    {:ok, expected_user: user}
  end

  describe "call/1" do
    test "When given a valid id removes a user" %{expected_user: expected_user} do
      assert {:ok, user} = Delete.call(%{id: expected_user.id})

      assert expected_user.id == user.id
    end

    test "When given an invalid id returns empty", %{expected_user: expected_user} do

      assert {:error, "Can't remove meal", reason: "Invalid Id"} = Delete.call(%{id: expected_meal.id + 1})
    end

    test "When given an invalid id param returns an error" do
      assert {:error,  "Can't remove meal", reason: "Invalid params"} = Delete.call(%{id: "string"})
    end
  end
end
