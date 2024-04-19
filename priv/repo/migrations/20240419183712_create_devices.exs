defmodule Glooko.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :manufacturer, :string, null: false
      add :model, :string, null: false
      add :serial_number, :string, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:devices, [:user_id])
    create unique_index(:devices, [:serial_number])
  end
end
