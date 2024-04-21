defmodule GlookoWeb.CalendarController do
  @moduledoc false
  use GlookoWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias GlookoWeb.Schemas.CalendarResponse
  alias Glooko.Devices

  operation(:index,
    summary: "Get graph",
    parameters: [
      user_id: [in: :path, description: "User ID", type: :integer, example: 1, required: true]
    ],
    responses: [
      ok: {"Graph Response", "application/json", CalendarResponse}
    ]
  )

  def index(conn, %{"user_id" => user_id}) do
    daily_device_readings = Devices.daily_user_devices_readings(user_id)
    render(conn, :index, %{daily_device_readings: daily_device_readings})
  end
end
