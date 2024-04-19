defmodule Glooko.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Glooko.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        date_of_birth: ~D[2024-04-18],
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        phone_number: "some phone_number"
      })
      |> Glooko.Accounts.create_user()

    user
  end
end
