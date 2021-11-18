defmodule Timemanager.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "test@test.fr",
        username: "username"
      })
      |> Timemanager.Users.create_user()

    user
  end
end
