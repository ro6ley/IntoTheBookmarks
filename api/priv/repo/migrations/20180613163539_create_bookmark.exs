defmodule IntoTheBookmarks.Repo.Migrations.CreateBookmark do
  use Ecto.Migration

  def change do
    create table(:bookmarks) do
      add :bookmark_title, :string
      add :bookmark_url, :string
      add :bookmark_notes, :string
      add :category_id, references(:categories, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:bookmarks, [:category_id])
    create index(:bookmarks, [:user_id])
  end
end
