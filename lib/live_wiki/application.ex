defmodule LiveWiki.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveWikiWeb.Telemetry,
      # Start the Ecto repository
      LiveWiki.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveWiki.PubSub},
      # Start Finch
      {Finch, name: LiveWiki.Finch},
      # Start the Endpoint (http/https)
      LiveWikiWeb.Endpoint
      # Start a worker by calling: LiveWiki.Worker.start_link(arg)
      # {LiveWiki.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveWiki.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveWikiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
