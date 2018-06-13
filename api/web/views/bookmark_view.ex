defmodule IntoTheBookmarks.BookmarkView do
  use IntoTheBookmarks.Web, :view

  def render("index.json", %{bookmarks: bookmarks}) do
    %{data: render_many(bookmarks, IntoTheBookmarks.BookmarkView, "bookmark.json")}
  end

  def render("show.json", %{bookmark: bookmark}) do
    %{data: render_one(bookmark, IntoTheBookmarks.BookmarkView, "bookmark.json")}
  end

  def render("bookmark.json", %{bookmark: bookmark}) do
    %{id: bookmark.id,
      bookmark_title: bookmark.bookmark_title,
      bookmark_url: bookmark.bookmark_url,
      bookmark_notes: bookmark.bookmark_notes,
      category_id: bookmark.category_id,
      user_id: bookmark.user_id}
  end
end
