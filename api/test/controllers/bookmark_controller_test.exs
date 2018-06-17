defmodule IntoTheBookmarks.BookmarkControllerTest do
  use IntoTheBookmarks.ConnCase

  alias IntoTheBookmarks.Bookmark
  alias IntoTheBookmarks.User
  alias IntoTheBookmarks.Category
  @valid_attrs %{bookmark_notes: "some bookmark_notes", bookmark_title: "some bookmark_title", bookmark_url: "some bookmark_url"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = Repo.insert! %User{email: "some content", is_active: true, password: "somepassword"}
    # category = Repo.insert! %Category{id: 1, category_name: "some category_name", category_notes: "some category_notes", user_id: user.id}
    conn = conn
      |> Plug.Test.init_test_session(current_user_id: user.id)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, category_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_id = get_session(conn, :current_user_id)
    category = Repo.insert! %Category{category_name: "some category_name", category_notes: "some category_notes", user_id: user_id}
    bookmark = Repo.insert!(Map.put(%Bookmark{}, :category_id, category.id) |> Map.put(:user_id, user_id))
    conn = get conn, "/api/categories/#{category.id}/bookmarks/", id: category.id
    IO.inspect json_response(conn, 200)
    assert match?(
        %{"id" => _,
        "bookmark_title" => _,
        "bookmark_url" => _,
        "bookmark_notes" => _,
        "category_id" => _,
        "user_id" => _
        },
        json_response(conn, 200)["data"])
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, category_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    user_id = get_session(conn, :current_user_id)
    category = Repo.insert! %Category{category_name: "some category_name", category_notes: "some category_notes", user_id: user_id}
    conn = post conn, "/api/categories/#{category.id}/bookmarks", %{bookmark: @valid_attrs, id: category.id}
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Bookmark, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    user_id = get_session(conn, :current_user_id)
    category = Repo.insert! %Category{category_name: "some category_name", category_notes: "some category_notes", user_id: user_id}
    conn = post conn, "/api/categories/#{category.id}/bookmarks", %{bookmark: @invalid_attrs, id: category.id}
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_id = get_session(conn, :current_user_id)
    category = Repo.insert! %Category{category_name: "some category_name", category_notes: "some category_notes", user_id: user_id}
    bookmark = Repo.insert! (Map.put(%Bookmark{}, :user_id, user_id) |> Map.put(:category_id, category.id))
    conn = put conn, bookmark_path(conn, :update, bookmark), bookmark: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Bookmark, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_id = get_session(conn, :current_user_id)
    bookmark = Repo.insert! Map.put(%Bookmark{}, :user_id, user_id)
    conn = put conn, bookmark_path(conn, :update, bookmark), bookmark: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_id = get_session(conn, :current_user_id)
    bookmark = Repo.insert! Map.put(%Bookmark{}, :user_id, user_id)
    conn = delete conn, bookmark_path(conn, :delete, bookmark)
    assert response(conn, 204)
    refute Repo.get(Bookmark, bookmark.id)
  end
end
