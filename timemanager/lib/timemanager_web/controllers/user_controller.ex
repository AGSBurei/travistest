
defmodule TimemanagerWeb.USERController do
  use TimemanagerWeb, :controller
   import Ecto.Query


  alias Timemanager.Users
  alias Timemanager.Users.USER
  alias TimemanagerWeb.Auth.Guardian

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, %{"username" => username,"email" => email}) do

    users = Users.list_users_by(username,email)
    render(conn, "index.json", users: users)
  end

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %USER{} = user} <- Users.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user)
     do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("user.json", %{user: user, token: token})
    end
  end

  def show(conn, %{"id" => id}) do
   user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
   user = Users.get_user!(id)

    with {:ok, %USER{} = user} <- Users.update_user(user, user_params) do
     render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
   user = Users.get_user!(id)

    with {:ok, %USER{}} <- Users.delete_user(user) do
     send_resp(conn, :no_content, "")
    end
  end
end
