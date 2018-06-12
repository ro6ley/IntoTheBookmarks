defmodule IntoTheBookmarks.UserView do
  use IntoTheBookmarks.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, IntoTheBookmarks.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, IntoTheBookmarks.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      is_active: user.is_active}
  end
end
