defmodule MetalMeeting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        # Start the Ecto repository
        MetalMeeting.Repo,
        # Start the Telemetry supervisor
        MetalMeetingWeb.Telemetry,
        # Start the PubSub system
        {Phoenix.PubSub, name: MetalMeeting.PubSub},
        # Start the Endpoint (http/https)
        MetalMeetingWeb.Endpoint
        # Start a worker by calling: MetalMeeting.Worker.start_link(arg)
        # {MetalMeeting.Worker, arg}
      ]
      |> append_if(Application.get_env(:my_app, :env) != :test, {Tz.UpdatePeriodically, []})

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MetalMeeting.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MetalMeetingWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp append_if(list, condition, item) do
    if condition, do: list ++ [item], else: list
  end
end
