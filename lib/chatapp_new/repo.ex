defmodule ChatappNew.Repo do
  use Ecto.Repo,
    otp_app: :chatapp_new,
    adapter: Ecto.Adapters.Postgres
end
