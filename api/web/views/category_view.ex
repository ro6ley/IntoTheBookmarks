defmodule IntoTheBookmarks.CategoryView do
  use IntoTheBookmarks.Web, :view

  alias IntoTheBookmarks.BookmarkView

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, IntoTheBookmarks.CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, IntoTheBookmarks.CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    # use the Bookmark view to render the list of bookmarks
    %{ data: bookmarks} = BookmarkView.render("index.json", bookmarks: category.bookmarks)

    %{id: category.id,
      category_name: category.category_name,
      category_notes: category.category_notes,
      user_id: category.user_id,
      bookmarks: bookmarks
    }
  end
end
