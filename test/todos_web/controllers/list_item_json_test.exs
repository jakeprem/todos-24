defmodule TodosWeb.ListItemJSONTest do
  use ExUnit.Case

  import Todos.Factory

  alias TodosWeb.ListItemJSON

  test "index/1 returns a list of items" do
    list = build(:list)
    item1 = build(:item, list: list, description: "test item 1")
    item2 = build(:item, list: list, description: "test item 2")

    assert %{
             data: [
               %{
                 id: item1.id,
                 description: item1.description,
                 done: item1.done,
                 listId: item1.list_id,
                 createdAt: item1.inserted_at,
                 updatedAt: item1.updated_at
               },
               %{
                 id: item2.id,
                 description: item2.description,
                 done: item2.done,
                 listId: item2.list_id,
                 createdAt: item2.inserted_at,
                 updatedAt: item2.updated_at
               }
             ]
           } ==
             ListItemJSON.index(%{items: [item1, item2]})
  end

  test "show/1 returns a single item" do
    list = build(:list)
    item = build(:item, list: list, description: "test item")

    assert %{
             data: %{
               id: item.id,
               description: item.description,
               done: item.done,
               listId: item.list_id,
               createdAt: item.inserted_at,
               updatedAt: item.updated_at
             }
           } ==
             ListItemJSON.show(%{item: item})
  end
end
