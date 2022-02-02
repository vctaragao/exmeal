defmodule ExmealWeb.MealController do
  use ExmealWeb, :exmeal_controller

  import ExmealWeb.Helper.Date

  @create_validation %{
    description: [type: :string, required: true, length: [min: 5, max: 140]],
    date: [type: :string, required: true, format: ~r/\d{2}\/\d{2}\/\d{4}/],
    hour: [type: :string, required: true, length: [min: 2, max: 2]],
    minute: [type: :string, required: true, length: [min: 2, max: 2]],
    calories: [type: :float, required: true]
  }

  def create(conn, params) do
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
      |> render("create.json", meal_id: meal.id)
    end
  end
end
