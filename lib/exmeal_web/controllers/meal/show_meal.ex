defmodule ExmealWeb.Controller.Meal.ShowMeal do
  use ExmealWeb, :exmeal_controller

  alias ExmealWeb.MealView

  @validation %{
    id: [type: :integer, required: true, number: [min: 0]]
  }

  def index(conn, params) do
    with {:ok, %{id: id}} <- Params.validate(params, @validation),
         {:ok, meal} <- Exmeal.get_meal(%{id: id}) do
      conn
      |> put_status(:ok)
      |> put_view(MealView)
      |> render("show.json", message: "Refeição retornada com sucesso", meal: meal)
    end
  end
end
