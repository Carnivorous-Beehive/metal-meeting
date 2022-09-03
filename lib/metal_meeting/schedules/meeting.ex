defmodule MetalMeeting.Schedules.Meeting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meetings" do
    field :name, :string
    belongs_to :user, MetalMeeting.Accounts.User
    field :scheduled_at, :utc_datetime
    field :recurring, :boolean

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:name, :user_id, :scheduled_at, :recurring])
    |> validate_required([:name, :scheduled_at])
    |> assoc_constraint(:user)
  end
end
