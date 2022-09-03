defmodule MetalMeeting.UserLiveAuth do
  import Phoenix.LiveView

  alias MetalMeeting.Accounts

  def on_mount(:default, _params, %{"user_token" => user_token} = _session, socket) do
    {:cont,
     socket
     |> assign_new(:current_user, fn -> Accounts.get_user_by_session_token(user_token) end)}
  end
end
