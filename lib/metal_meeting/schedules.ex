defmodule MetalMeeting.Schedules do
  @moduledoc """
  The Schedules context.
  """

  import Ecto.Query, warn: false
  alias MetalMeeting.Repo

  alias MetalMeeting.Schedules.Meeting

  @doc """
  Returns the list of meetings.

  ## Examples

      iex> list_meetings()
      [%Meeting{}, ...]

  """
  def list_meetings do
    Repo.all(Meeting)
  end

  @doc """
  Gets a single meeting.

  Raises `Ecto.NoResultsError` if the Meeting does not exist.

  ## Examples

      iex> get_meeting!(123)
      %Meeting{}

      iex> get_meeting!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meeting!(id), do: Repo.get!(Meeting, id)

  @doc """
  Creates a meeting.

  ## Examples

      iex> create_meeting(%{field: value})
      {:ok, %Meeting{}}

      iex> create_meeting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meeting(attrs \\ %{}) do
    %Meeting{}
    |> Meeting.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meeting.

  ## Examples

      iex> update_meeting(meeting, %{field: new_value})
      {:ok, %Meeting{}}

      iex> update_meeting(meeting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meeting(%Meeting{} = meeting, attrs) do
    meeting
    |> Meeting.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a meeting.

  ## Examples

      iex> delete_meeting(meeting)
      {:ok, %Meeting{}}

      iex> delete_meeting(meeting)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meeting(%Meeting{} = meeting) do
    Repo.delete(meeting)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meeting changes.

  ## Examples

      iex> change_meeting(meeting)
      %Ecto.Changeset{data: %Meeting{}}

  """
  def change_meeting(%Meeting{} = meeting, attrs \\ %{}) do
    Meeting.changeset(meeting, attrs)
  end

  @doc """
  Get upcoming Meetings.

  ## Examples

      iex> get_upcoming_meetings(3)
      [%Meeting{}, %Meeting{}, %Meeting{}
  """
  def get_upcoming_meetings(count) do
    query = Meeting |> limit(^count) |> order_by(desc: :scheduled_at)
    Repo.all(query)
  end

  def get_upcoming_meetings do
    get_upcoming_meetings(5)
  end
end
