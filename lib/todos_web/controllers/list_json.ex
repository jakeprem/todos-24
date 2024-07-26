defmodule TodosWeb.ListJSON do
  alias Todos.List

  def index(%{lists: lists}) do
    %{data: for(list <- lists, do: data(list))}
  end

  def show(%{list: list}) do
    %{data: data(list)}
  end

  defp data(%List{} = list) do
    %{id: list.id, name: list.name, createdAt: list.inserted_at, updatedAt: list.updated_at}
  end
end
