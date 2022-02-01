defmodule ExmealWeb.Validation.Params do
  def validate(params, %{} = schema) do
    Tarams.cast(params, schema)
    |> handle_validation_result()
  end

  defp handle_validation_result({:ok, result}), do: {:ok, result}

  defp handle_validation_result({:error, reason}),
    do: {:error, "Erro de validação", reason: reason, domain: "valdi"}
end
