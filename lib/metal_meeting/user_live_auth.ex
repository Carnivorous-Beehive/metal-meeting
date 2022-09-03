defmodule MetalMeeting.UserLiveAuth do
  import Phoenix.LiveView

  alias MetalMeeting.Accounts

  def on_mount(:default, _params, %{"user_token" => user_token} = _session, socket) do
    socket =
      assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(user_token) end)

    {:cont, socket}
  end
end
