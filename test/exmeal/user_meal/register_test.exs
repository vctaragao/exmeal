defmodule Exmeal.UserMeal.RegisterTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.Repo
  alias Exmeal.UserMeal.Register

  setup do
    {:ok, user} = build(:user) |> Repo.insert()
    {:ok, user_id: user.id}
  end

  describe "call/1" do
    test "When given valid params register a list of meal to a user", %{user_id: id} do
      meal_list = [build_meal("canja"), build_meal("macarrão"), build_meal("pizza")]
      assert {:ok, message} = Register.call(%{user_id: id, meals: meal_list})
      assert "Meals registered succefully" == message
    end

    test "When given invalid params returns an error", %{user_id: id} do
      meal_list = [build_meal("canja"), build_meal("macarrão"), build_meal("pizza")]

      assert {:error, message, reason: reason} = Register.call(%{user_id: id, meal: meal_list})
      assert "Can't insert meals to user" == message
      assert "invalid params" == reason
    end

    test "When given invalid meals returns an error", %{user_id: id} do
      meal_list = [
        build_meal("canja"),
        build(:meal_params, %{calories: "calorias"}),
        build_meal("macarrão")
      ]

      assert {:error, message, reason: reason} = Register.call(%{user_id: id, meals: meal_list})
      assert "Can't insert meals to user" == message
      assert "invalid meal format" == reason
    end

    test "When given invalid user id returns an error", %{user_id: id} do
      meal_list = [build_meal("canja"), build_meal("macarrão"), build_meal("pizza")]

      assert {:error, message, reason: reason} =
               Register.call(%{user_id: id + 1, meals: meal_list})

      assert "Can't insert meals to user" == message
      assert "invalid Id" == reason
    end
  end

  defp build_meal(description), do: build(:meal_params, %{description: description})
end
