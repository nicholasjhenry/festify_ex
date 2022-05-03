import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :festify_promotion, FestifyPromotionWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "y2B8OyYpez5ApEStPSOeSlC+C2eXL9l8Ne4BnkJFUYoYCqZMC5kXPrvLtOvHUI60",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
