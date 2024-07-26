defmodule TodosWeb.ListJSONTest do
  use ExUnit.Case

  import Todos.Factory

  alias TodosWeb.ListJSON

  test "index/1 returns a list of lists" do
    list1 = build(:list, name: "test list 1")
    list2 = build(:list, name: "test list 2")

    assert %{data: [%{id: list1.id, name: list1.name}, %{id: list2.id, name: list2.name}]} ==
             ListJSON.index(%{lists: [list1, list2]})
  end

  test "show/1 returns a single list" do
    list = build(:list, name: "test list")

    assert %{data: %{id: list.id, name: list.name}} ==
             ListJSON.show(%{list: list})
  end
end
