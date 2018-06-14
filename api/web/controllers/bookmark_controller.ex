defmodule IntoTheBookmarks.BookmarkController do
  use IntoTheBookmarks.Web, :controller

  alias IntoTheBookmarks.Bookmark
  alias IntoTheBookmarks.Category

  def index(conn, %{"id" => category_id}) do
    category = Repo.get!(Category, category_id)
    bookmarks = Repo.all(Bookmark)
    render(conn, "index.json", bookmarks: bookmarks)
  end

  def create(conn, %{"bookmark" => bookmark_params, "id" => category_id}) do
    category = Repo.get!(Category, category_id)
    user_id = get_session(conn, :current_user_id)
    changeset = Bookmark.changeset(%Bookmark{}, Map.put(bookmark_params, "category_id", category_id) |> Map.put("user_id", user_id))

    case Repo.insert(changeset) do
      {:ok, bookmark} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", bookmark_path(conn, :show, bookmark))
        |> render("show.json", bookmark: bookmark)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(IntoTheBookmarks.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bookmark = Repo.get!(Bookmark, id)
    render(conn, "show.json", bookmark: bookmark)
  end

  def update(conn, %{"id" => id, "bookmark" => bookmark_params}) do
    bookmark = Repo.get!(Bookmark, id)
    changeset = Bookmark.changeset(bookmark, bookmark_params)

    case Repo.update(changeset) do
      {:ok, bookmark} ->
        render(conn, "show.json", bookmark: bookmark)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(IntoTheBookmarks.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bookmark = Repo.get!(Bookmark, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bookmark)

    send_resp(conn, :no_content, "")
  end
end