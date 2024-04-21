defmodule Glooko.Devices.DeviceReading do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias Glooko.Devices.Device

  @derive {Jason.Encoder, only: [:glucose_value, :timestamp, :device_id]}
  schema "device_readings" do
    field :glucose_value, :integer
    field :timestamp, :utc_datetime
    belongs_to :device, Device

    timestamps(type: :utc_datetime, updated_at: false)
  end

  @doc false
  def changeset(device_reading, attrs) do
    device_reading
    |> cast(attrs, [:timestamp, :glucose_value, :device_id])
    |> validate_required([:timestamp, :glucose_value])
  end
end
