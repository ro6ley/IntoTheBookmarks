use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :into_the_bookmarks, IntoTheBookmarks.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :bcrypt_elixir, :log_rounds, 4

# Configure your database
config :into_the_bookmarks, IntoTheBookmarks.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "robley",
  password: "",
  database: "into_the_bookmarks_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
