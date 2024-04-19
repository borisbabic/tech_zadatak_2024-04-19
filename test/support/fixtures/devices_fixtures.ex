defmodule Glooko.DevicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Glooko.Devices` context.
  """

  @doc """
  Generate a device.
  """
  def device_fixture(attrs \\ %{}) do
    {:ok, device} =
      attrs
      |> Enum.into(%{
        manufacturer: "some manufacturer",
        model: "some model",
        serial_number: "some serial_number"
      })
      |> Glooko.Devices.create_device()

    device
  end

  @doc """
  Generate a device_reading.
  """
  def device_reading_fixture(attrs \\ %{}, device_attrs \\ %{}) do
    %{id: device_id} = device_fixture(device_attrs)
    {:ok, device_reading} =
      attrs
      |> Enum.into(%{
        device_id: device_id,
        glucose_value: 42,
        timestamp: ~U[2024-04-18 18:53:00Z]
      })
      |> Glooko.Devices.create_device_reading()

    device_reading
  end
end
