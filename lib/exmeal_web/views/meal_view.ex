defmodule ExmealWeb.MealView do
  use ExmealWeb, :view

  def render("create.json", %{meal_id: meal_id}) do
    %{
      message: "Refeição criada com sucesso",
      data: %{meal_id: meal_id}
    }
  end
end
