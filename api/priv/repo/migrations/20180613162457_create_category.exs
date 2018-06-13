defmodule IntoTheBookmarks.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :category_name, :string
      add :category_notes, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:categories, [:user_id])
  end
end
