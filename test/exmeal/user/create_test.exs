defmodule Exmeal.User.CreateTest do
  use Exmeal.DataCase, async: true

  alias Exmeal.User.Create
  alias Exmeal.User

  setup_all do
    {:ok, params: build(:user_params)}
  end

  describe "call/1" do
    test "When given valid params create a valid user record", %{params: params} do
      assert {:ok, %User{}} = Create.call(params)
    end

    test "When given invalid params returns an erros", %{params: params} do
      response = Create.call(%{params | name: "a"})

      assert {
               :error,
               "Can't register user",
               [reason: [info: %{field: "name", reason: "should be at least 2 character(s)"}]]
             } == response
    end

    test "When given invalid params key returns an errros", %{params: params} do
      response =
        params
        |> Map.delete(:name)
        |> Map.put(:n, "Victor Moraes")
        |> Create.call()

      assert {:error, "Can't register user", [reason: "invalid params"]} == response
    end
  end
end
