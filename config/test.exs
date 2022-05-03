import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :festify, Festify.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "festify_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :festify_web, FestifyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "EBTUrt6gnm2+BZ20VFbkfIgtJCLB/R0KfaALy7ZjpJo3OOxghDoOZTt6KADqTi6R",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# In test we don't send emails.
config :festify, Festify.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
