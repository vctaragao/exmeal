defmodule ExmealWeb.Controller.User.DeleteUser do
  use ExmealWeb, :exmeal_controller

  alias ExmealWeb.UserView

  @validation %{
    id: [type: :integer, required: true, number: [min: 0]]
  }

  def index(conn, params) do
    with {:ok, %{id: id}} <- Params.validate(params, @validation),
         {:ok, _} <- Exmeal.delete_user(%{id: id}) do
      conn
      |> put_status(:no_content)
      |> put_view(UserView)
      |> render("delete.json")
    end
  end
end
