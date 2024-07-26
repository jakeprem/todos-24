defmodule TodosWeb.ListItemJSON do
  alias Todos.Item

  def index(%{items: items}) do
    %{data: for(item <- items, do: data(item))}
  end

  def show(%{item: item}) do
    %{data: data(item)}
  end

  defp data(%Item{} = item) do
    %{id: item.id, description: item.description, done: item.done}
  end
end
