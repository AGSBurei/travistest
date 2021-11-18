defmodule Timemanager.Users.USER do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string, null: false
    field :username, :string, null: false
    field :password, :string, virtual: true
    field :password_hash, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string
    #has_many :workingtimes, TimeManager.WorkingTimes.Workingtime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user

    |> cast(attrs, [:username, :email, :password, :firstname, :lastname, :role])
    |> validate_required([:email, :password])
    |> unique_constraint(:username, message: "username existe déja")
    |> unique_constraint(:email, message: "email existe déja")
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:password, min: 8)
    |> validate_inclusion(:role, ~w(employee manager generalmanager admin))
    |> put_hashed_password
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
          changeset
    end
  end



end
