defmodule MetalMeetingWeb.MeetingLive.Show do
  use MetalMeetingWeb, :live_view
  on_mount MetalMeeting.UserLiveAuth

  alias MetalMeeting.Schedules

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:meeting, Schedules.get_meeting!(id))}
  end

  defp page_title(:show), do: "Show Meeting"
  defp page_title(:edit), do: "Edit Meeting"
end
