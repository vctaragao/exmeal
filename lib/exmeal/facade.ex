defmodule Exmeal.Facade do
  alias Exmeal.Meal.{Create, Get, Update, Delete}

  alias Exmeal.User.Create, as: CreateUser
  alias Exmeal.User.Update, as: UpdateUser

  defdelegate create_meal(params), to: Create, as: :call
  defdelegate get_meal(params), to: Get, as: :call
  defdelegate update_meal(params), to: Update, as: :call
  defdelegate delete_meal(params), to: Delete, as: :call

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate update_user(params), to: UpdateUser, as: :call
end
