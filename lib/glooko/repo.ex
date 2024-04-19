defmodule Glooko.Repo do
  use Ecto.Repo,
    otp_app: :glooko,
    adapter: Ecto.Adapters.Postgres
end
