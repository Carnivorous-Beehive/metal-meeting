defmodule MetalMeeting.SchedulesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MetalMeeting.Schedules` context.
  """

  @doc """
  Generate a meeting.
  """
  def meeting_fixture(attrs \\ %{}) do
    {:ok, meeting} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> MetalMeeting.Schedules.create_meeting()

    meeting
  end
end
