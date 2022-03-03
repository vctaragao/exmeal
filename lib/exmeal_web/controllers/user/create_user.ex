defmodule ExmealWeb.Controller.User.CreateUser do
  use ExmealWeb, :exmeal_controller

  alias ExmealWeb.UserView

  @validation %{
    name: [type: :string, required: true, length: [min: 2]],
    cpf: [type: :string, required: true, format: ~r/\d{3}\.\d{3}\.\d{3}\-\d{2}/],
    email: [type: :string, required: true, format: ~r/@/]
  }

  def index(conn, params) do
    with {:ok, params} <- Params.validate(params, @validation),
         {:ok, user} <-
           Exmeal.create_user(%{name: params[:name], cpf: params[:cpf], email: params[:email]}) do
      conn
      |> put_status(:created)
      |> put_view(UserView)
      |> render("create.json", user_id: user.id)
    end
  end
end
