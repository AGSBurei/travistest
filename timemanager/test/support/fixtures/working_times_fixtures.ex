defmodule Timemanager.WorkingTimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.WorkingTimes` context.
  """

  import Timemanager.UsersFixtures

  alias Timemanager.Users.USER

  def fixture(:user) do
    Repo.insert! %USER{username: "Daniel Berkompas", email: "test@example.com"}
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime, user} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-10-25 07:56:00],
        start: ~N[2021-10-25 07:56:00],
        user: "1"
      })
      |> Timemanager.WorkingTimes.create_workingtime()

    workingtime
  end
end
