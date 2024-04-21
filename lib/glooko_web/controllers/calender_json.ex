defmodule GlookoWeb.CalendarJSON do
  def index(%{daily_device_readings: data}), do: %{data: data}
end
