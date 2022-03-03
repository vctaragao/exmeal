defmodule Exmeal do
  def schema do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      alias Ecto.Changeset

      defp handle_changeset(%Changeset{} = changeset) do
        if changeset.valid?, do: {:ok, changeset}, else: handle_error(changeset.errors)
      end

      defp handle_error([{field, {reason, [{key, value} | _]}} | _] = errors) do
        reason =
          if String.contains?(reason, "%"), do: format_reason(reason, key, value), else: reason

        {:error, info: %{field: Atom.to_string(field), reason: reason}}
      end

      defp format_reason(reason, key, value) when is_integer(value) do
        String.replace(reason, "%{#{key}}", Integer.to_string(value))
      end
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
