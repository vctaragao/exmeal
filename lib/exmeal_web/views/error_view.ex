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
    %{
      message: msg,
      data: %{field: field, error: translate_error(reason, domain)}
    }
  end
end
