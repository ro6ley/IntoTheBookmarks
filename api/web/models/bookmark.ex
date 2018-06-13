defmodule IntoTheBookmarks.Bookmark do
  use IntoTheBookmarks.Web, :model

  schema "bookmarks" do
    field :bookmark_title, :string
    field :bookmark_url, :string
    field :bookmark_notes, :string
    belongs_to :category, IntoTheBookmarks.Category, foreign_key: :category_id
    belongs_to :user, IntoTheBookmarks.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:bookmark_title, :bookmark_url, :bookmark_notes, :category_id, :user_id])
    |> validate_required([:bookmark_title, :bookmark_url, :category_id, :user_id])
  end
end
