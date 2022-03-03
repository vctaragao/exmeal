defmodule Exmeal.User.Get do
  alias Exmeal.Repo
  alias Exmeal.User

  def call(%{id: id}) when is_integer(id), do: get_meal(id) |> handle_result()

  def call(_), do: {:error, "Can't return user", reason: "Invalid params"}

  defp get_meal(id), do: Repo.get(User, id)

  defp handle_result(%User{} = user), do: {:ok, user}
  defp handle_result(nil), do: {:ok, %{}}
end
