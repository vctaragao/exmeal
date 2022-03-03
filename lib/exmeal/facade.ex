defmodule Exmeal.Facade do
  alias Exmeal.Meal.{Create, Get, Update, Delete}

  defdelegate create_meal(params), to: Create, as: :call
  defdelegate get_meal(params), to: Get, as: :call
  defdelegate update_meal(params), to: Update, as: :call
  defdelegate delete_meal(params), to: Delete, as: :call
end
