defmodule Todos.Repo.Migrations.CreateListsAndItems do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :name, :string

      timestamps()
    end

    create table(:items) do
      add :description, :string
      add :done, :boolean, default: false
      add :list_id, references(:lists, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:lists, [:name])
    create index(:items, [:list_id])
  end
end
