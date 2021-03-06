defmodule ExmealWeb.FallbackController do
  use ExmealWeb, :controller

  alias ExmealWeb.ErrorView

  def call(conn, {:error, msg, %{reason: reason, domain: domain}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.json", %{message: msg, reason: reason, domain: domain})
  end

  def call(conn, {:error, msg, [{:reason, reason} | _]}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.json", %{message: msg, reason: reason, domain: "errors"})
  end
end
