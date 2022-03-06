defmodule ExmealWeb.Router do
  use ExmealWeb, :router

  alias Controller.Meal.{CreateMeal, ShowMeal, UpdateMeal, DeleteMeal}
  alias Controller.User.{CreateUser, UpdateUser, ShowUser, DeleteUser}

  pipeline(:api) do
    plug :accepts, ["json"]
  end

  scope "/api", ExmealWeb do
    pipe_through :api

    post "/meal", CreateMeal, :index
    get "/meal/:id", ShowMeal, :index
    patch "/meal/:id", UpdateMeal, :index
    delete "/meal/:id", DeleteMeal, :index

    post "/user", CreateUser, :index
    patch "/user/:id", UpdateUser, :index
    get "/user/:id", ShowUser, :index
    delete "/user/:id", DeleteUser, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ExmealWeb.Telemetry
    end
  end
end
