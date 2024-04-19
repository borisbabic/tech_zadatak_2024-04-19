defmodule Glooko.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :date_of_birth, :date
      add :email, :string, uniq: true
      add :phone_number, :string

      timestamps(type: :utc_datetime)
    end
  end
end
