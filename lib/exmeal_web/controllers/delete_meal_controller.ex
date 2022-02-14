defmodule ExmealWeb.DeleteMealController do
  use ExmealWeb, :exmeal_controller

  @validation %{
    id: [type: :integer, required: true, number: [min: 0]]
  }

  def index(conn, params) do
    with {:ok, %{id: id}} <- Params.validate(params, @validation),
         {:ok, _} <- Exmeal.delete_meal(%{id: id}) do
      conn
      |> put_status(:no_content)
      |> put_view(MealView)
      |> render("delete.json")
    end
  end
end
