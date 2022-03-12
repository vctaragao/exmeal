defmodule ExmealWeb.UserMealView do
  use ExmealWeb, :view

  def render("create.json", _) do
    %{
      message: "Refeições registradas com sucesso",
      data: %{}
    }
  end
end
