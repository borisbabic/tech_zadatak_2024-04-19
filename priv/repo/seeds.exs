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

Glooko.Repo.insert!(%User{
  first_name: "Boris",
  last_name: "Babic",
  email: "boris.ivan.babic@gmail.com",
  phone_number: "1-800-555-001",
  date_of_birth: ~D[1970-01-01]
})

Glooko.Repo.insert!(%User{
  first_name: "Kristijan",
  last_name: "Novoselic",
  email: "kristijan@example.com",
  phone_number: "1-800-555-001",
  date_of_birth: ~D[1970-01-02]
})
