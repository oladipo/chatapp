defmodule ChatappNew.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChatappNewWeb.Telemetry,
      ChatappNew.Repo,
      {DNSCluster, query: Application.get_env(:chatapp_new, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ChatappNew.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ChatappNew.Finch},
      # Start a worker by calling: ChatappNew.Worker.start_link(arg)
      # {ChatappNew.Worker, arg},
      # Start to serve requests, typically the last entry
      ChatappNewWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChatappNew.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatappNewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
