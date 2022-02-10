defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo

  alias Exmeal.Meal

  def meal_params_factory do
    %{
      calories: 100.50,
      date: DateTime.utc_now(),
      description: "descrição"
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
end
