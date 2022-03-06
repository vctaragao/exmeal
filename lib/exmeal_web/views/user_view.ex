defmodule ExmealWeb.UserView do
  use ExmealWeb, :view

  alias Exmeal.User

  def render("create.json", %{user_id: id}) do
    %{
      message: "Usuário criado com sucesso",
      data: %{user_id: id}
    }
  end

  def render("show.json", %{user: %User{} = user}) do
    %{
      message: "Usuário retornado com sucesso",
      data: %{
        id: user.id,
        name: user.name,
        cpf: user.cpf,
        email: user.email
      }
    }
  end

  def render("show.json", %{user: %{}}) do
    %{
      message: "Usuário retornado com sucesso",
      data: %{}
    }
  end

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
