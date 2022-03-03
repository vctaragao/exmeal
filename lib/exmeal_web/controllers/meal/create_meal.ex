defmodule ExmealWeb.Controller.Meal.CreateMeal do
  use ExmealWeb, :exmeal_controller

  import ExmealWeb.Helper.Date

  alias ExmealWeb.MealView

  @create_validation %{
    description: [type: :string, required: true, length: [min: 5, max: 140]],
    date: [type: :string, required: true, format: ~r/\d{2}\/\d{2}\/\d{4}/],
    hour: [type: :integer, required: true, number: [min: 0, max: 23]],
    minute: [type: :integer, required: true, number: [min: 0, max: 59]],
    calories: [type: :float, required: true]
  }

  def index(conn, params) do
    with {:ok, params} <- Params.validate(params, @create_validation),
         {:ok, datetime, _} <- format_to_datetime(params[:date], params[:hour], params[:minute]),
         {:ok, meal} <-
           Exmeal.create_meal(%{
             description: params[:description],
             date: datetime,
             calories: params[:calories]
           }) do
      conn
      |> put_status(:created)
      |> put_view(MealView)
      |> render("create.json", meal_id: meal.id)
    end
  end
end
