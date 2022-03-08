defmodule ExmealWeb.Controller.UserMeal.CreateUserMeal do
  use ExmealWeb, :exmeal_controller

  import ExmealWeb.Helper.Date

  alias ExmealWeb.UserMealView

  def index(conn, params) do
    validation = %{
      user_id: [type: :integer, required: true, number: [min: 0]],
      meals: [
        required: true,
        cast_func: fn meals ->
          formated_meals =
            Jason.decode!(meals)
            |> Enum.map(&format_meal/1)

          {:ok, formated_meals}
        end
      ]
    }

    with {:ok, validated_params} <- Params.validate(params, validation),
         {:ok, _} <- Exmeal.create_user_meals(validated_params) do
      conn
      |> put_status(:no_content)
      |> put_view(UserMealView)
      |> render("create.json")
    end
  end

  defp format_meal(meal) do
    {:ok, date, _} = format_to_datetime(meal["date"], meal["hour"], meal["minute"])

    %{
      description: meal["description"],
      calories: meal["calories"] / 1,
      date: date
    }
  end
end
