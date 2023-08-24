defmodule LiveWiki.Repo do
  use Ecto.Repo,
    otp_app: :live_wiki,
    adapter: Ecto.Adapters.Postgres
end
