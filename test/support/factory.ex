defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo

  alias Exmeal.{Meal, User}

  def meal_params_factory do
    %{
      calories: 100.50,
      date: DateTime.utc_now() |> DateTime.truncate(:second),
      description: "descrição"
    }
  end

  def meal_action_params_factory do
    %{
      description: "descrição",
      date: "28/01/2022",
      hour: 10,
      minute: 10,
      calories: 100
    }
  end

  def meal_factory do
    %Meal{
      id: 1,
      calories: 100.50,
      date: DateTime.utc_now() |> DateTime.truncate(:second),
      description: "descrição"
    }
  end

  def user_params_factory do
    %{
      name: "Meu nome",
      cpf: "012.345.678-10",
      email: "email@test.com"
    }
  end

  def user_factory do
    %User{
      id: 1,
      name: "Victor Moraes de Aragão",
      cpf: "123.456.789-10",
      email: "email@test.com"
    }
  end

  def user_meal_params_factory do
    %{
      user_id: 1,
      meals: [build_meal("canja"), build_meal("macarrão"), build_meal("pizza")]
    }
  end

  defp build_meal(description), do: build(:meal_action_params, %{description: description})
end
