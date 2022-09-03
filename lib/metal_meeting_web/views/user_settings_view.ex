defmodule MetalMeetingWeb.UserSettingsView do
  use MetalMeetingWeb, :view

  def oauth?(current_user) do
    current_user.avatar && current_user.username
  end
end
