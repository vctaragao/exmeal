defmodule Exmeal.User.GetTest do
  use Exmeal.DataCase, async: true

  alias Exmeal.User.Get
  alias Exmeal.Repo

  setup do
    {:ok, user} = build(:user) |> Repo.insert()
    {:ok, expected_user: user}
  end

  describe "call/1" do
    test "When given a valid id returns a user", %{expected_user: expected_user} do
      assert {:ok, user} = Get.call(%{id: expected_user.id})

      assert expected_user == user
    end

    test "When given an invalid id returns empty", %{expected_user: expected_user} do
      assert {:ok, %{}} = Get.call(%{id: expected_user.id + 1})
    end

    test "When given an invalid id param returns an error" do
      assert {:error, "Can't return user", [reason: "Invalid params"]} = Get.call(%{id: "string"})
    end
  end
end
