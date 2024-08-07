defmodule Todos.List do
  @moduledoc """
  A list of tasks (items) that need to be done.
  """
  use Ecto.Schema

  import Ecto.Changeset

  schema "lists" do
    field :name, :string

    has_many :items, Todos.Item

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
