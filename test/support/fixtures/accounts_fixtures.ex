defmodule MetalMeeting.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MetalMeeting.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password: "some password",
        username: "some username"
      })
      |> MetalMeeting.Accounts.create_user()

    user
  end
end
