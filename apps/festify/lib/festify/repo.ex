defmodule Festify.Repo do
  use Ecto.Repo,
    otp_app: :festify,
    adapter: Ecto.Adapters.Postgres
end
