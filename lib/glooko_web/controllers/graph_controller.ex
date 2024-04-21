defmodule GlookoWeb.GraphController do
  @moduledoc false
  use GlookoWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias GlookoWeb.Schemas.{GraphResponse, ErrorResponse}

  operation(:index,
    summary: "Get graph",
    parameters: [
      user_id: [in: :path, description: "User ID", type: :integer, example: 1, required: true],
      start_date: [
        in: :query,
        description:
          "Start date in YYYY-MM-DD format. Max 90 days in the past. Default: 2 weeks ago",
        type: :string,
        example: "2024-03-01"
      ],
      end_date: [
        in: :query,
        description:
          "Start date in YYYY-MM-DD format. Max 90 days in the past. Default: current day",
        type: :string,
        example: "2024-04-21"
      ],
      devices: [
        in: :query,
        description:
          "List of device serial numbers to check. Default: returns all devices for user",
        example: []
      ]
    ],
    responses: [
      ok: {"Graph Response", "application/json", GraphResponse},
      bad_request: {"Invalid Date Range", "application/json", ErrorResponse}
    ]
  )

  def index(conn, _params) do
    json(conn, "Hello World")
  end
end
