defmodule IntoTheBookmarks.UserView do
  use IntoTheBookmarks.Web, :view

  def render("index.json", %{users: users}) do
    %{users: render_many(users, IntoTheBookmarks.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, IntoTheBookmarks.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      names: user.names,
      is_active: user.is_active,
      joined: user.inserted_at
    }
  end
end
