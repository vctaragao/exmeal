defmodule ExmealWeb.Helper.Date do
  def format_to_datetime(date, hour, minute) do
    date = format_date(date)
    time = format_time(hour, minute)

    DateTime.from_iso8601("#{date}T#{time}Z")
  end

  def format_date(date) do
    date
    |> String.split("/")
    |> Enum.reverse()
    |> Enum.join("-")
  end

  def format_time(hour, minute, seconds \\ "00") do
    hour = pad_time(hour)
    minute = pad_time(minute)
    seconds = pad_time(seconds)

    "#{hour}:#{minute}:#{seconds}"
  end

  defp pad_time(time) when is_bitstring(time), do: String.pad_leading(time, 2, "00")

  defp pad_time(time) when is_integer(time),
    do: time |> Integer.to_string() |> String.pad_leading(2, "00")
end
