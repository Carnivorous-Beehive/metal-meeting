defmodule MetalMeeting.SchedulesTest do
  use MetalMeeting.DataCase

  alias MetalMeeting.Schedules

  describe "meetings" do
    alias MetalMeeting.Schedules.Meeting

    import MetalMeeting.SchedulesFixtures

    @invalid_attrs %{name: nil}

    test "list_meetings/0 returns all meetings" do
      meeting = meeting_fixture()
      assert Schedules.list_meetings() == [meeting]
    end

    test "get_meeting!/1 returns the meeting with given id" do
      meeting = meeting_fixture()
      assert Schedules.get_meeting!(meeting.id) == meeting
    end

    test "create_meeting/1 with valid data creates a meeting" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Meeting{} = meeting} = Schedules.create_meeting(valid_attrs)
      assert meeting.name == "some name"
    end

    test "create_meeting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedules.create_meeting(@invalid_attrs)
    end

    test "update_meeting/2 with valid data updates the meeting" do
      meeting = meeting_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Meeting{} = meeting} = Schedules.update_meeting(meeting, update_attrs)
      assert meeting.name == "some updated name"
    end

    test "update_meeting/2 with invalid data returns error changeset" do
      meeting = meeting_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedules.update_meeting(meeting, @invalid_attrs)
      assert meeting == Schedules.get_meeting!(meeting.id)
    end

    test "delete_meeting/1 deletes the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{}} = Schedules.delete_meeting(meeting)
      assert_raise Ecto.NoResultsError, fn -> Schedules.get_meeting!(meeting.id) end
    end

    test "change_meeting/1 returns a meeting changeset" do
      meeting = meeting_fixture()
      assert %Ecto.Changeset{} = Schedules.change_meeting(meeting)
    end
  end
end
