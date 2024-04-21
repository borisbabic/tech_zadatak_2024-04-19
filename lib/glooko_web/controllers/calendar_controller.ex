defmodule GlookoWeb.CalendarController do
  @moduledoc false
  use GlookoWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias GlookoWeb.Schemas.CalendarResponse

  operation(:index,
    summary: "Get graph",
    parameters: [
      user_id: [in: :path, description: "User ID", type: :integer, example: 1, required: true]
    ],
    responses: [
      ok: {"Graph Response", "application/json", CalendarResponse}
    ]
  )

  def index(conn, _params) do
    json(conn, "Hello World")
  end
end
