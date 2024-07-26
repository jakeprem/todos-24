defmodule Todos do
  @moduledoc """
  For an app this small we can fit everything in a single top level context.
  """

  alias Todos.List
  # alias Todos.Item
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
end
