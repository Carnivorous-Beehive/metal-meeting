defmodule MetalMeeting.Repo.Migrations.AddInfoAvatarAndNameFieldsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :info, :jsonb
      add :avatar, :string
      add :name, :text
    end
  end
end
