defmodule ExmealWeb.FallbackController do
  use ExmealWeb, :controller

  alias ExmealWeb.ErrorView

  def call(conn, {:error, msg, %{reason: reason, domain: domain} = error}) do
    IO.inspect(error)

    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.json", %{message: msg, reason: reason, domain: domain})
  endz
end
