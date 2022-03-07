defmodule ExmealWeb.Controller.UserMeal.CreateUserMeal do
  use ExmealWeb, :exmeal_controller

  import ExmealWeb.Helper.Date

  alias ExmealWeb.UserMealView

  def index(conn, params) do
    validation = %{
      user_id: [type: :integer, required: true, length: [min: 0]],
      meals: [required: true, cast_fun: &meals_parser/1]
    }

    with {:ok, validated_params} <- Params.validate(params, validation),
         formated_params <- %{params | meals: Enum.map(validated_params[:meals], &format_meal/1)},
         {:ok, _} <- Exmeal.create_user_meals(formated_params) do
      conn
      |> put_status(:no_content)
      |> put_view(UserMealView)
      |> render("create.json")
    end
  end

  def meals_parser(meal) do
    IO.inspect(Jason.decode!(meal))
  end

  defp format_meal(params) do
    %{
      description: params[:description],
      calories: params[:calories],
      date: format_to_datetime(params[:date], params[:hour], params[:minute])
    }
  end
end
