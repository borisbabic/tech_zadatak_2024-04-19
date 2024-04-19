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

deice_boris_1 =
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
