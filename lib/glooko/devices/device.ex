defmodule Glooko.Devices.Device do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Glooko.Accounts.User

  schema "devices" do
    field :manufacturer, :string
    field :model, :string
    field :serial_number, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:manufacturer, :model, :serial_number])
    |> validate_required([:manufacturer, :model, :serial_number])
    |> unique_constraint(:serial_number)
  end
end
