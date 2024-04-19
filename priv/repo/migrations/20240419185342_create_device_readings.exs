defmodule Glooko.Repo.Migrations.CreateDeviceReadings do
  use Ecto.Migration

  def change do
    create table(:device_readings) do
      add :timestamp, :utc_datetime, null: false
      add :glucose_value, :integer, null: false
      add :device_id, references(:devices, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime, updated_at: false)
    end

    create index(:device_readings, [:device_id])
  end
end
