defmodule Todos.Factory do
  @moduledoc false
  alias Todos.Repo

  def build(:list) do
    %Todos.List{name: "Test todo list"}
  end

  def build(:item) do
    %Todos.Item{description: "Test todo item", done: false}
  end

  def build(factory_name, attrs) do
    factory_name
    |> build()
    |> struct!(attrs)
  end

  def insert!(factory_name, attrs \\ []) do
    factory_name
    |> build(attrs)
    |> Repo.insert!()
  end
end
