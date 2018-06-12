defmodule IntoTheBookmarks.UserTest do
  use IntoTheBookmarks.ModelCase

  alias IntoTheBookmarks.User

  @valid_attrs %{email: "some content", is_active: true, password: "somepassword"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
