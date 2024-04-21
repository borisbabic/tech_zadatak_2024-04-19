defmodule Glooko.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias Glooko.Repo

  alias Glooko.Devices.Device

  @doc """
  Returns the list of devices.

  ## Examples

      iex> list_devices()
      [%Device{}, ...]

  """
  def list_devices do
    Repo.all(Device)
  end

  @doc """
  Gets a single device.

  Raises `Ecto.NoResultsError` if the Device does not exist.

  ## Examples

      iex> get_device!(123)
      %Device{}

      iex> get_device!(456)
      ** (Ecto.NoResultsError)

  """
  def get_device!(id), do: Repo.get!(Device, id)

  @doc """
  Creates a device.

  ## Examples

      iex> create_device(%{field: value})
      {:ok, %Device{}}

      iex> create_device(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_device(attrs \\ %{}) do
    %Device{}
    |> Device.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a device.

  ## Examples

      iex> update_device(device, %{field: new_value})
      {:ok, %Device{}}

      iex> update_device(device, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_device(%Device{} = device, attrs) do
    device
    |> Device.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a device.

  ## Examples

      iex> delete_device(device)
      {:ok, %Device{}}

      iex> delete_device(device)
      {:error, %Ecto.Changeset{}}

  """
  def delete_device(%Device{} = device) do
    Repo.delete(device)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking device changes.

  ## Examples

      iex> change_device(device)
      %Ecto.Changeset{data: %Device{}}

  """
  def change_device(%Device{} = device, attrs \\ %{}) do
    Device.changeset(device, attrs)
  end

  alias Glooko.Devices.DeviceReading

  @doc """
  Returns the list of device_readings.

  ## Examples

      iex> list_device_readings()
      [%DeviceReading{}, ...]

  """
  def list_device_readings do
    Repo.all(DeviceReading)
  end

  @doc """
  Gets a single device_reading.

  Raises `Ecto.NoResultsError` if the Device reading does not exist.

  ## Examples

      iex> get_device_reading!(123)
      %DeviceReading{}

      iex> get_device_reading!(456)
      ** (Ecto.NoResultsError)

  """
  def get_device_reading!(id), do: Repo.get!(DeviceReading, id)

  @doc """
  Creates a device_reading.

  ## Examples

      iex> create_device_reading(%{field: value})
      {:ok, %DeviceReading{}}

      iex> create_device_reading(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_device_reading(attrs \\ %{}) do
    %DeviceReading{}
    |> DeviceReading.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a device_reading.

  ## Examples

      iex> update_device_reading(device_reading, %{field: new_value})
      {:ok, %DeviceReading{}}

      iex> update_device_reading(device_reading, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_device_reading(%DeviceReading{} = device_reading, attrs) do
    device_reading
    |> DeviceReading.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a device_reading.

  ## Examples

      iex> delete_device_reading(device_reading)
      {:ok, %DeviceReading{}}

      iex> delete_device_reading(device_reading)
      {:error, %Ecto.Changeset{}}

  """
  def delete_device_reading(%DeviceReading{} = device_reading) do
    Repo.delete(device_reading)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking device_reading changes.

  ## Examples

      iex> change_device_reading(device_reading)
      %Ecto.Changeset{data: %DeviceReading{}}

  """
  def change_device_reading(%DeviceReading{} = device_reading, attrs \\ %{}) do
    DeviceReading.changeset(device_reading, attrs)
  end

  @type daily_device_readings :: %{device_id: integer(), date: String.t(), count: integer()}
  @spec daily_user_devices_readings(user_id :: integer()) :: [daily_device_readings()]
  def daily_user_devices_readings(user_id) do
    from(dr in DeviceReading,
      inner_join: d in assoc(dr, :device),
      where: d.user_id == ^user_id,
      select: %{
        device_id: d.id,
        date: fragment("?::date", dr.timestamp),
        count: count(dr.id)
      },
      group_by: fragment("1, 2")
    )
    |> Repo.all()
  end
end
