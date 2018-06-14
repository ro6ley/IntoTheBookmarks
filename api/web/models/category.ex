defmodule IntoTheBookmarks.Category do
  use IntoTheBookmarks.Web, :model

  schema "categories" do
    field :category_name, :string
    field :category_notes, :string
    belongs_to :user, IntoTheBookmarks.User, foreign_key: :user_id
    has_many :bookmarks, IntoTheBookmarks.Bookmark

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:category_name, :category_notes, :user_id])
    |> validate_required([:category_name, :category_notes])
  end
end
