defmodule Exmeal do
  @moduledoc """
  Exmeal keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Exmeal.{CreateMeal, GetMeal, UpdateMeal}

  defdelegate create_meal(params), to: CreateMeal, as: :call
  defdelegate get_meal(params), to: GetMeal, as: :call
  defdelegate update_meal(params), to: UpdateMeal, as: :call
end
