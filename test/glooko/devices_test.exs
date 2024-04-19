defmodule Glooko.DevicesTest do
  use Glooko.DataCase

  alias Glooko.Devices

  describe "devices" do
    alias Glooko.Devices.Device

    import Glooko.DevicesFixtures

    @invalid_attrs %{manufacturer: nil, model: nil, serial_number: nil}

    test "list_devices/0 returns all devices" do
      device = device_fixture()
      assert Devices.list_devices() == [device]
    end

    test "get_device!/1 returns the device with given id" do
      device = device_fixture()
      assert Devices.get_device!(device.id) == device
    end

    test "create_device/1 with valid data creates a device" do
      valid_attrs = %{
        manufacturer: "some manufacturer",
        model: "some model",
        serial_number: "some serial_number"
      }

      assert {:ok, %Device{} = device} = Devices.create_device(valid_attrs)
      assert device.manufacturer == "some manufacturer"
      assert device.model == "some model"
      assert device.serial_number == "some serial_number"
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()

      update_attrs = %{
        manufacturer: "some updated manufacturer",
        model: "some updated model",
        serial_number: "some updated serial_number"
      }

      assert {:ok, %Device{} = device} = Devices.update_device(device, update_attrs)
      assert device.manufacturer == "some updated manufacturer"
      assert device.model == "some updated model"
      assert device.serial_number == "some updated serial_number"
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_device(device, @invalid_attrs)
      assert device == Devices.get_device!(device.id)
    end

    test "delete_device/1 deletes the device" do
      device = device_fixture()
      assert {:ok, %Device{}} = Devices.delete_device(device)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_device!(device.id) end
    end

    test "change_device/1 returns a device changeset" do
      device = device_fixture()
      assert %Ecto.Changeset{} = Devices.change_device(device)
    end
  end

  describe "device_readings" do
    alias Glooko.Devices.DeviceReading

    import Glooko.DevicesFixtures

    @invalid_attrs %{glucose_value: nil, timestamp: nil}

    test "list_device_readings/0 returns all device_readings" do
      device_reading = device_reading_fixture()
      assert Devices.list_device_readings() == [device_reading]
    end

    test "get_device_reading!/1 returns the device_reading with given id" do
      device_reading = device_reading_fixture()
      assert Devices.get_device_reading!(device_reading.id) == device_reading
    end

    test "create_device_reading/1 with valid data creates a device_reading" do
      %{id: device_id} = device_fixture()
      valid_attrs = %{glucose_value: 42, timestamp: ~U[2024-04-18 18:53:00Z], device_id: device_id}

      assert {:ok, %DeviceReading{} = device_reading} = Devices.create_device_reading(valid_attrs)
      assert device_reading.glucose_value == 42
      assert device_reading.timestamp == ~U[2024-04-18 18:53:00Z]
    end

    test "create_device_reading/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_device_reading(@invalid_attrs)
    end

    test "update_device_reading/2 with valid data updates the device_reading" do
      device_reading = device_reading_fixture()
      update_attrs = %{glucose_value: 43, timestamp: ~U[2024-04-19 18:53:00Z]}

      assert {:ok, %DeviceReading{} = device_reading} =
               Devices.update_device_reading(device_reading, update_attrs)

      assert device_reading.glucose_value == 43
      assert device_reading.timestamp == ~U[2024-04-19 18:53:00Z]
    end

    test "update_device_reading/2 with invalid data returns error changeset" do
      device_reading = device_reading_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Devices.update_device_reading(device_reading, @invalid_attrs)

      assert device_reading == Devices.get_device_reading!(device_reading.id)
    end

    test "delete_device_reading/1 deletes the device_reading" do
      device_reading = device_reading_fixture()
      assert {:ok, %DeviceReading{}} = Devices.delete_device_reading(device_reading)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_device_reading!(device_reading.id) end
    end

    test "change_device_reading/1 returns a device_reading changeset" do
      device_reading = device_reading_fixture()
      assert %Ecto.Changeset{} = Devices.change_device_reading(device_reading)
    end
  end
end
