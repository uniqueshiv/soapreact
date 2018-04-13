# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :soapreact,
  ecto_repos: [Soapreact.Repo]

# Configures the endpoint
config :soapreact, SoapreactWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5296uIVd9yZSKoUd/H7ZhFPuxbrmOC3MavgfwNG/2eAX7lE+uO0HTs8W7QximYO4",
  render_errors: [view: SoapreactWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Soapreact.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# for pagination html
config :scrivener_html,
  routes_helper: Soapreact.Router.Helpers,
  # If you use a single view style everywhere, you can configure it here. See View Styles below for more info.
  view_style: :bootstrap

#auth gurading
config :soapreact, Soapreact.Auth.Guardian,
     issuer: "soapreact",
     secret_key: "qbVEsOl3rPxUIsvTPxNn5iSMraeJEG3ybGUhIDGF+LVpUUB2vdf5onnijo/Ceap9"
 #
 config :soapreact, SoapreactWeb.AuthPipeline,
     module: SoapreactWeb.Guardian,
     error_handler: SoapreactWeb.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
