defmodule ExmealWeb.ErrorView do
  use ExmealWeb, :view

  import ExmealWeb.ErrorHelpers

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("400.json", %{message: msg, reason: {field, reason}, domain: domain}) do
    translated_error = split_reason_and_value(reason) |> translate_reason(domain)

    %{
      message: msg,
      data: %{field: field, error: translated_error}
    }
  end

  defp split_reason_and_value(reason) do
    {value, reason_list} = reason |> String.split(" ") |> List.pop_at(-1)

    case Integer.parse(value) do
      {int_value, _} -> {:ok, {preapre_reason_with_value(reason_list), int_value}}
      :error -> {:error, reason}
    end
  end

  defp preapre_reason_with_value(reason_list) do
    reason = Enum.join(reason_list, " ")
    reason <> " %{value}"
  end

  defp translate_reason({:ok, {reason, value}}, domain),
    do: translate_error(reason, domain, %{value: value})

  defp translate_reason({:error, reason}, domain), do: translate_error(reason, domain)
end
