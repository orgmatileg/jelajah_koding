defmodule JelajahKodingWeb.Presence do
  use Phoenix.Presence,
    otp_app: :jelajah_koding,
    pubsub_server: JelajahKoding.PubSub
end
