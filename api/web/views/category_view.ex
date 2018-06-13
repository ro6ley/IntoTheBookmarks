defmodule IntoTheBookmarks.CategoryView do
  use IntoTheBookmarks.Web, :view

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, IntoTheBookmarks.CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, IntoTheBookmarks.CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id,
      category_name: category.category_name,
      category_notes: category.category_notes,
      user_id: category.user_id
    }
  end
end
