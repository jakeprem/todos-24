defmodule Todos.Todos.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :description, :string
    field :done, :boolean, default: false
    belongs_to :list, Todos.Todos.List

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:description, :done])
    |> validate_required([:description])
  end
end
