defmodule Timemanager.Users do
  import Ecto.Query
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Timemanager.Repo
  alias TimemanagerWeb.Auth.Guardian

  alias Timemanager.Users.USER

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%USER{}, ...]

  """

  def list_users_by(username,email) do
   result = USER

    |> where(username: ^username, email: ^email)
    Repo.all(result)

  end

  def list_users do
    Repo.all(USER)
   end



  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %USER{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(USER, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %USER{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %USER{}
    |> USER.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %USER{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%USER{} = user, attrs) do
    user
    |> USER.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %USER{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%USER{} = user) do
    Repo.delete(user)
  end

  def get_by_email(email) do
    case Repo.get_by(USER, email: email) do
      nil ->
        {:error, :not_found}
      user ->
        {:ok, user}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %USER{}}

  """
  def change_user(%USER{} = user, attrs \\ %{}) do
    USER.changeset(user, attrs)
  end
end
