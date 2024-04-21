defmodule GlookoWeb.GraphJSON do
  def index(%{user_readings: user_readings}), do: %{data: user_readings}
end
