defmodule IntoTheBookmarks.BookmarkTest do
  use IntoTheBookmarks.ModelCase

  alias IntoTheBookmarks.Bookmark

  @valid_attrs %{bookmark_notes: "some bookmark_notes", bookmark_title: "some bookmark_title", bookmark_url: "some bookmark_url"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bookmark.changeset(%Bookmark{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bookmark.changeset(%Bookmark{}, @invalid_attrs)
    refute changeset.valid?
  end
end
