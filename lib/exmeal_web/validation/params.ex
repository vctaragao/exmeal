defmodule ExmealWeb.Validation.Params do
  def validate(params, %{} = schema) do
    Tarams.cast(params, schema)
    |> handle_validation_result()
  end

  defp handle_validation_result({:ok, result}), do: {:ok, result}

  defp handle_validation_result({:error, reason}) do
    [first | _] = Map.keys(reason)

    {
      :error,
      "Erro de validação",
      %{reason: {Atom.to_string(first), List.first(reason[first])}, domain: "valdi"}
    }
  end
end
