defmodule GlookoWeb.GraphController do
  @moduledoc false
  use GlookoWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias Glooko.Error
  alias Glooko.Devices
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

  def index(conn, %{"user_id" => user_id} = params) do
    with {:ok, start_date} <- start_date(params),
         {:ok, end_date} <- end_date(params),
         {:ok, devices} <- devices(params) do
      readings = Devices.user_readings(user_id, {start_date, end_date}, devices)
      render(conn, :index, %{user_readings: readings})
    else
      error -> render_error(conn, Error.new(error))
    end
  end

  def start_date(%{"start_date" => start_date}) do
    handle_string_date(start_date)
  end

  def start_date(_), do: {:ok, Date.utc_today() |> Date.add(-13)}

  def end_date(%{"end_date" => end_date}) do
    handle_string_date(end_date)
  end

  def end_date(_), do: {:ok, Date.utc_today()}

  defp handle_string_date(raw_date) do
    with {:ok, date} <- parse_date(raw_date),
         :ok <- validate_date(date) do
      {:ok, date}
    end
  end

  defp validate_date(date, max_diff \\ 90) do
    diff = Date.diff(Date.utc_today(), date)

    if diff > max_diff do
      {:error,
       %Error{
         code: 400,
         slug: :invalid_date_range,
         message: "#{date} is too far in the past, max 90 days ago"
       }}
    else
      :ok
    end
  end

  defp parse_date(date_string) do
    with {:error, _} <- Date.from_iso8601(date_string) do
      {:error,
       %Error{
         code: 400,
         slug: :invalid_date_format,
         message: "#{date_string} is not a valid date in a YYYY-MM-DD format"
       }}
    end
  end

  defp devices(%{"devices" => devices}), do: {:ok, devices}
  defp devices(_), do: {:ok, []}
end
