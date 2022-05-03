# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :festify_promotion,
  ecto_repos: [Festify.Repo]

# Configures the endpoint
config :festify_promotion, FestifyPromotionWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: FestifyPromotionWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FestifyPromotion.PubSub,
  live_view: [signing_salt: "NXR0JdVJ"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
