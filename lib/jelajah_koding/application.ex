defmodule JelajahKoding.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JelajahKodingWeb.Telemetry,
      JelajahKoding.Repo,
      {DNSCluster, query: Application.get_env(:jelajah_koding, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JelajahKoding.PubSub},
      JelajahKodingWeb.Presence,
      # Start the Finch HTTP client for sending emails
      {Finch, name: JelajahKoding.Finch},
      # Start a worker by calling: JelajahKoding.Worker.start_link(arg)
      # {JelajahKoding.Worker, arg},
      # Start to serve requests, typically the last entry
      JelajahKodingWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JelajahKoding.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JelajahKodingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
