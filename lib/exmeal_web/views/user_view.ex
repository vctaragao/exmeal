defmodule ExmealWeb.UserView do
  use ExmealWeb, :view

  def render("create.json", %{user_id: id}) do
    %{
      message: "Usuário criado com sucesso",
      data: %{user_id: id}
    }
  end

  # def render("show.json", %{meal: %Meal{} = meal}) do
  #   %{
  #     message: "Refeição retornada com sucesso",
  #     data: %{
  #       id: meal.id,
  #       description: meal.description,
  #       date: DateTime.to_string(meal.date),
  #       calories: meal.calories
  #     }
  #   }
  # end

  # def render("show.json", %{meal: %{}}) do
  #   %{
  #     message: "Refeição retornada com sucesso",
  #     data: %{}
  #   }
  # end

  def render("update.json", %{user_id: id}) do
    %{
      message: "Usuário atualizado com sucesso",
      data: %{user_id: id}
    }
  end

  # def render("delete.json", _) do
  #   %{
  #     message: "Refeição removida com sucesso",
  #     data: %{}
  #   }
  # end
end
