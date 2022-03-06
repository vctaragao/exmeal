defmodule ExmealWeb.Controller.User.ShowUser do
  use ExmealWeb, :exmeal_controller

  alias ExmealWeb.UserView

  @validation %{
    id: [type: :integer, required: true, number: [min: 0]]
  }

  def index(conn, params) do
    with {:ok, %{id: id}} <- Params.validate(params, @validation),
         {:ok, user} <- Exmeal.get_user(%{id: id}) do
      conn
      |> put_status(:ok)
      |> put_view(UserView)
      |> render("show.json", message: "Usuário retornado com sucesso", user: user)
    end
  end
end
