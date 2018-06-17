defmodule IntoTheBookmarks.CategoryTest do
  use IntoTheBookmarks.ModelCase

  alias IntoTheBookmarks.Category

  @valid_attrs %{category_name: "some category_name", category_notes: "some category_notes", user_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, @invalid_attrs)
    refute changeset.valid?
  end
end
