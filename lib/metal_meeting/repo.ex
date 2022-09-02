defmodule MetalMeeting.Repo do
  use Ecto.Repo,
    otp_app: :metal_meeting,
    adapter: Ecto.Adapters.Postgres
end
