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
end
