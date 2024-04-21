defmodule GlookoWeb.Schemas do
  @moduledoc "Contains schemas for openapi specs"
  require OpenApiSpex
  alias OpenApiSpex.Schema

  defmodule GraphNode do
    @moduledoc false
    OpenApiSpex.schema(%{
      title: "GraphNode",
      description: "A graph node",
      type: :object,
      properties: %{
        timestamp: %Schema{
          type: :string,
          description: "Timestamp of when it was measured formatted in iso8601",
          example: "2024-04-21T17:30:00Z"
        },
        glucose_value: %Schema{type: :integer, description: "In mg/dL"}
      },
      example: %{
        "timestamp" => 1_713_706_075_046,
        "glucose_value" => 99
      }
    })
  end

  defmodule GraphResponse do
    @moduledoc false
    OpenApiSpex.schema(%{
      title: "Graph Response",
      description: "Response schema for graph",
      type: :object,
      properties: %{
        data: %Schema{description: "The details", type: :array, items: GraphNode}
      },
      example: %{
        "data" => [
          %{
            "timestamp" => 1_713_706_075_046,
            "glucose_value" => 99
          },
          %{
            "timestamp" => 1_713_706_999_999,
            "glucose_value" => 120
          }
        ]
      }
    })
  end

  defmodule DeviceDailyCount do
    @moduledoc false
    OpenApiSpex.schema(%{
      title: "DeviceDailyCount",
      description: "Number of readings for a device for a day",
      type: :object,
      properties: %{
        serial_number: %Schema{type: :string},
        date: %Schema{
          type: :string,
          description: "The data in YYYY-MM-DD format",
          pattern: ~r/[0-9]{4}-[0-9]{2}-[0-9]{2}/
        },
        count: %Schema{type: :integer, description: "The number of readings for the date"}
      },
      example: %{
        "serial_number" => "ser_num_123",
        "date" => "2024-04-21",
        "count" => 21
      }
    })
  end

  defmodule CalendarResponse do
    @moduledoc false
    OpenApiSpex.schema(%{
      title: "CalendarResponse",
      description: "Response schema for the user's device calendar",
      type: :object,
      properties: %{
        data: %Schema{
          description: "The daily counts for the user's devices",
          type: :array,
          items: DeviceDailyCount
        }
      },
      example: %{
        "data" => [
          %{
            "serial_number" => "ser_num_123",
            "date" => "2024-04-21",
            "count" => 21
          },
          %{
            "serial_number" => "ser_num_123",
            "date" => "2024-04-20",
            "count" => 19
          }
        ]
      }
    })
  end

  defmodule ErrorResponse do
    @moduledoc "Generic Error Response"
    OpenApiSpex.schema(%{
      title: "ErrorResponse",
      description: "Error response for an invalid date range",
      type: :object,
      properties: %{
        error: %Schema{
          description: "Error Object",
          type: :object,
          properties: %{
            slug: %Schema{
              description: "The unique slug for the error",
              type: :string,
              example: "invalid_date_range"
            },
            message: %Schema{
              description: "Error message",
              type: "string",
              example: "Invalid date range requested. Max 90 days in the past"
            }
          }
        }
      },
      example: %{
        "error" => %{
          "slug" => "invalid_date_range",
          "message" => "Start date can't be older than 90 days ago"
        }
      }
    })
  end
end
