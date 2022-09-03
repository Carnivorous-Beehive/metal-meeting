defmodule MetalMeeting.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :info
      modify :avatar, :text
    end
  end
end
