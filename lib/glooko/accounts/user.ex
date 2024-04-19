defmodule Glooko.Accounts.User do
  @moduledoc "User entity"
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :date_of_birth, :date
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :date_of_birth, :email, :phone_number])
    |> validate_required([:first_name, :last_name, :date_of_birth, :email, :phone_number])
  end
end
