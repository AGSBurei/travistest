defmodule TimemanagerWeb.USERView do
  use TimemanagerWeb, :view
  alias TimemanagerWeb.USERView
  alias TimemanagerWeb.Auth.Guardian

  def render("index.json", %{users: users}) do
    %{data: render_many(users, USERView, "user1.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, USERView, "user1.json")}
  end

  def render("user1.json", %{user: user}) do
   %{
     id: user.id,
     username: user.username,
     email: user.email,
     role: user.role
   }
  end
  def render("user.json", %{user: user, token: token}) do
    %{data: %{user: %{email: user.email, role: user.role, id: user.id, username: user.username}, token: token }}


  end
end
