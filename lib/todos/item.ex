defmodule Todos.Item do
  @moduledoc """
  An item in a todo list.
  """
  use Ecto.Schema

  import Ecto.Changeset

  schema "items" do
    field :description, :string
    field :done, :boolean, default: false
    belongs_to :list, Todos.List

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:description, :done, :list_id])
    |> validate_required([:description, :list_id])
    |> foreign_key_constraint(:list_id)
  end
end
