defmodule ExmealWeb.MealView do
  use ExmealWeb, :view

  alias Exmeal.Meal

  def render("create.json", %{meal_id: meal_id}) do
    %{
      message: "Refeição criada com sucesso",
      data: %{meal_id: meal_id}
    }
  end

  def render("show.json", %{meal: %Meal{} = meal}) do
    %{
      message: "Refeição retornada com sucesso",
      data: %{
        id: meal.id,
        description: meal.description,
        date: DateTime.to_string(meal.date),
        calories: meal.calories
      }
    }
  end

  def render("show.json", %{meal: %{}}) do
    %{
      message: "Refeição retornada com sucesso",
      data: %{}
    }
  end
end
