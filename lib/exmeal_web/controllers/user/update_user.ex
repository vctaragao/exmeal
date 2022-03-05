defmodule ExmealWeb.Controller.User.UpdateUser do
  use ExmealWeb, :exmeal_controller

  alias ExmealWeb.UserView

  @validation %{
    id: [type: :integer, required: true],
    name: [type: :string, required: true, length: [min: 2]],
    cpf: [type: :string, required: true, format: ~r/\d{3}\.\d{3}\.\d{3}\-\d{2}/],
    email: [type: :string, required: true, format: ~r/@/]
  }

  def index(conn, params) do
    with {:ok, params} <- Params.validate(params, @validation),
         {:ok, user} <-
           Exmeal.update_user(%{
             id: params[:id],
             name: params[:name],
             cpf: params[:cpf],
             email: params[:email]
           }) do
      conn
      |> put_status(:ok)
      |> put_view(UserView)
      |> render("update.json", user_id: user.id)
    end
  end
end
