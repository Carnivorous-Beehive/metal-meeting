defmodule MetalMeeting.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :scheduled_at, :utc_datetime, null: false
      add :recurring, :boolean, null: false, default: false

      timestamps()
    end
  end
end
