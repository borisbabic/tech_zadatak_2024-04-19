# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Glooko.Repo.insert!(%Glooko.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Glooko.Accounts.User
alias Glooko.Devices.Device
alias Glooko.Devices.DeviceReading

boris =
  Glooko.Repo.insert!(%User{
    first_name: "Boris",
    last_name: "Babic",
    email: "boris.ivan.babic@gmail.com",
    phone_number: "1-800-555-001",
    date_of_birth: ~D[1970-01-01]
  })

kristijan =
  Glooko.Repo.insert!(%User{
    first_name: "Kristijan",
    last_name: "Novoselic",
    email: "kristijan@example.com",
    phone_number: "1-800-555-001",
    date_of_birth: ~D[1970-01-02]
  })

device_boris_1 =
  Glooko.Repo.insert!(%Device{
    manufacturer: "Porsche",
    model: "T-1000",
    serial_number: "ser-num-1",
    user_id: boris.id
  })

device_boris_2 =
  Glooko.Repo.insert!(%Device{
    manufacturer: "Ferrari",
    model: "9001",
    serial_number: "ser-num-2",
    user_id: boris.id
  })

device_kris_1 =
  Glooko.Repo.insert!(%Device{
    manufacturer: "Porsche",
    model: "T-1000",
    serial_number: "ser-num-3",
    user_id: kristijan.id
  })

defmodule Simulator do
  def per_day(device, date, count, glucose_value_range \\ 70..100) do
    hours(count)
    |> Enum.map(fn hour ->
      minute = Enum.random(15..45)
      time = Time.new!(hour, minute, 00)
      timestamp = DateTime.new!(date, time)
      now = DateTime.utc_now(:second)

      %{
        timestamp: timestamp,
        glucose_value: Enum.random(glucose_value_range),
        device_id: device.id,
        inserted_at: now
      }
    end)
  end

  def hours(count) when count <= 24 do
    Enum.take_random(0..23, count)
  end

  def hours(count) do
    for _ <- 1..count do
      Enum.random(0..23)
    end
  end
end

thirty_days_ago = Date.add(Date.utc_today(), -30)

# simulate broken device
working_b1 =
  Enum.flat_map(0..21, fn working_day ->
    date = Date.add(thirty_days_ago, working_day)
    num_readings = Enum.random(10..20)
    Simulator.per_day(device_boris_1, date, num_readings)
  end)

Glooko.Repo.insert_all(DeviceReading, working_b1)

overloaded_b1 =
  Enum.flat_map(22..24, fn overloaded_day ->
    date = Date.add(thirty_days_ago, overloaded_day)
    num_readings = Enum.random(100..500)
    Simulator.per_day(device_boris_1, date, num_readings, 0..1000)
  end)

Glooko.Repo.insert_all(DeviceReading, overloaded_b1)

# Working device for me, but readings can be high
working_b2 =
  Enum.flat_map(0..30, fn working_day ->
    date = Date.add(thirty_days_ago, working_day)
    num_readings = Enum.random(10..20)

    Simulator.per_day(device_boris_2, date, num_readings, 90..200)
  end)

Glooko.Repo.insert_all(DeviceReading, working_b2)

# working for kristijan and normal readings
working_k1 =
  Enum.flat_map(0..30, fn working_day ->
    date = Date.add(thirty_days_ago, working_day)
    num_readings = Enum.random(10..20)

    Simulator.per_day(device_kris_1, date, num_readings)
  end)

Glooko.Repo.insert_all(DeviceReading, working_k1)
