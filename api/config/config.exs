# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :into_the_bookmarks,
  ecto_repos: [IntoTheBookmarks.Repo]

# Same as
# config(app, key, opts)
# config(:into_the_bookmarks, ecto_repos: [IntoTheBookmarks.Repo])

# Configures the endpoint
config :into_the_bookmarks, IntoTheBookmarks.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "L51/DycZNh9tM9Nti1LjSJ5P6D0J1hpPk8HXjUzjrgtBV04aP48R+PXjoTXn95al",
  render_errors: [view: IntoTheBookmarks.ErrorView, accepts: ~w(json)],
  pubsub: [name: IntoTheBookmarks.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
