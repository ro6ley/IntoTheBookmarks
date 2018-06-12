defmodule IntoTheBookmarks.Endpoint do
  use Phoenix.Endpoint, otp_app: :into_the_bookmarks

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :into_the_bookmarks, gzip: false,
    only: ~w()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_into_the_bookmarks_key",
    signing_salt: "fLODt3hF"

  plug Corsica,
    origins: "http://localhost:8080",
    log: [rejected: :error, invalid: :warn, accepted: :debug],
    allow_headers: ["content-type"],
    allow_credentials: true

  plug IntoTheBookmarks.Router
end
