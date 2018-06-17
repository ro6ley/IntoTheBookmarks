defmodule IntoTheBookmarks.CategoryControllerTest do
  use IntoTheBookmarks.ConnCase

  alias IntoTheBookmarks.Category
  alias IntoTheBookmarks.User
  @valid_attrs %{category_name: "some category_name", category_notes: "some category_notes"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = Repo.insert! %User{email: "some content", is_active: true, password: "somepassword"}
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
    category = Repo.insert! Map.put(%Category{}, :user_id, user_id)
    conn = get conn, category_path(conn, :show, category)
    assert json_response(conn, 200)["data"] == %{"id" => category.id,
      "category_name" => category.category_name,
      "category_notes" => category.category_notes,
      "user_id" => category.user_id,
      "bookmarks" => []}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, category_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, category_path(conn, :create), category: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Category, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, category_path(conn, :create), category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_id = get_session(conn, :current_user_id)
    category = Repo.insert! Map.put(%Category{}, :user_id, user_id)
    conn = put conn, category_path(conn, :update, category), category: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Category, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_id = get_session(conn, :current_user_id)
    category = Repo.insert! Map.put(%Category{}, :user_id, user_id)
    conn = put conn, category_path(conn, :update, category), category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_id = get_session(conn, :current_user_id)
    category = Repo.insert! Map.put(%Category{}, :user_id, user_id)
    conn = delete conn, category_path(conn, :delete, category)
    assert response(conn, 204)
    refute Repo.get(Category, category.id)
  end
end
