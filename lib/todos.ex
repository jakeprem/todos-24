defmodule Todos do
  @moduledoc """
  Manage todo lists and items.

  For an app this small we can fit everything in a single top level context.
  """

  import Ecto.Query

  alias Todos.Item
  alias Todos.List
  alias Todos.Repo

  @doc """
  List all todo lists.
  """
  def list_lists do
    Repo.all(List)
  end

  @doc """
  Get a todo list by ID.
  """
  def get_list(id) do
    Repo.get(List, id)
  end

  @doc """
  Create a new todo list.
  """
  def create_list(attrs) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update a todo list.
  """
  def update_list(%List{} = list, attrs) do
    list
    |> List.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a todo list.
  """
  def delete_list(%List{} = list) do
    Repo.delete(list)
  end

  @doc """
  Returns all items, regardless of the list they belong to
  """
  def list_items do
    Repo.all(Item)
  end

  @doc """
  List all items for a todo list.
  """
  def list_list_items(list_id) do
    Repo.all(from(i in Item, where: i.list_id == ^list_id))
  end

  @doc """
  Get an item by ID.
  """
  def get_item(id) do
    Repo.get(Item, id)
  end

  @doc """
  Create a new item.
  """
  def create_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.safe_insert()
  end

  @doc """
  Update an item.
  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.safe_update()
  end

  @doc """
  Delete an item.
  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end
end
