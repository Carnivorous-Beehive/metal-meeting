defmodule MetalMeetingWeb.AuthController do
  use MetalMeetingWeb, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias MetalMeeting.UserFromAuth
  alias MetalMeetingWeb.UserAuth

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    UserAuth.log_out_user(conn)
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case UserFromAuth.find_or_create(auth) do
      {:ok, user} ->
        UserAuth.log_in_user(conn, user, params)

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
