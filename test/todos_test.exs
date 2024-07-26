defmodule TodosTest do
  use Todos.DataCase, async: false

  describe "list_lists/0" do
    test "returns all lists" do
      list = insert!(:list, name: "test list 1")
      list2 = insert!(:list, name: "test list 2")

      result = Todos.list_lists()
      assert list in result
      assert list2 in result
    end

    test "returns empty list if no lists" do
      assert [] == Todos.list_lists()
    end
  end

  describe "get_list/1" do
    test "returns the correct list" do
      list = insert!(:list, name: "test list 1")
      list2 = insert!(:list, name: "test list 2")

      assert list == Todos.get_list(list.id)
      assert list2 == Todos.get_list(list2.id)
    end

    test "returns nil if list does not exist" do
      assert nil == Todos.get_list(1)
    end
  end

  describe "create_list/1" do
    test "creates a list" do
      assert {:ok, list} = Todos.create_list(%{name: "test list"})

      assert list.id
      assert list.name == "test list"
    end

    test "returns errors if invalid" do
      list = Todos.create_list(%{})

      assert {:error, changeset} = list
      assert {"can't be blank", _} = changeset.errors[:name]
    end
  end

  describe "update_list/1" do
    test "updates a list" do
      list = insert!(:list, name: "test list")

      assert {:ok, updated_list} = Todos.update_list(list, %{name: "updated list"})

      assert updated_list.id == list.id
      assert updated_list.name == "updated list"
    end

    test "returns errors if invalid" do
      list = insert!(:list, name: "test list")

      assert {:error, changeset} = Todos.update_list(list, %{name: ""})

      assert {"can't be blank", _} = changeset.errors[:name]
    end
  end

  describe "delete_list/1" do
    test "deletes a list" do
      list = insert!(:list, name: "test list")

      assert {:ok, _} = Todos.delete_list(list)
      assert nil == Todos.get_list(list.id)
    end
  end

  describe "list_items/0" do
    test "returns all items" do
      list = insert!(:list)
      list2 = insert!(:list, name: "test list 2")

      item = insert!(:item, description: "test item 1", list_id: list.id)
      item2 = insert!(:item, description: "test item 2", list_id: list2.id)

      result = Todos.list_items()
      assert item in result
      assert item2 in result
    end

    test "returns empty list if no items" do
      assert [] == Todos.list_items()
    end
  end

  describe "list_list_items/1" do
    test "returns all items for a list" do
      list = insert!(:list)
      list2 = insert!(:list, name: "test list 2")
      item = insert!(:item, list_id: list.id, description: "test item 1")
      item2 = insert!(:item, list_id: list.id, description: "test item 2")
      list2_item = insert!(:item, list_id: list2.id, description: "test item 3")

      result = Todos.list_list_items(list.id)

      assert item in result
      assert item2 in result
      refute list2_item in result
    end

    test "returns empty list if no items" do
      list = insert!(:list)
      list2 = insert!(:list, name: "test list 2")

      insert!(:item, list_id: list2.id)

      assert [] == Todos.list_list_items(list.id)
    end
  end

  describe "get_item/1" do
    test "returns the correct item" do
      item = insert!(:item, description: "test item 1")
      item2 = insert!(:item, description: "test item 2")

      assert item == Todos.get_item(item.id)
      assert item2 == Todos.get_item(item2.id)
    end

    test "returns nil if item does not exist" do
      assert nil == Todos.get_item(1)
    end
  end

  describe "create_item/1" do
    test "creates an item" do
      list = insert!(:list)
      assert {:ok, item} = Todos.create_item(%{list_id: list.id, description: "test item"})

      assert item.id
      assert item.description == "test item"
    end

    test "returns errors if invalid" do
      item = Todos.create_item(%{})

      assert {:error, changeset} = item
      assert {"can't be blank", _} = changeset.errors[:description]
    end
  end

  describe "update_item/1" do
    test "updates an item" do
      list = insert!(:list)
      item = insert!(:item, description: "test item", list_id: list.id)

      assert {:ok, updated_item} = Todos.update_item(item, %{description: "updated item"})

      assert updated_item.id == item.id
      assert updated_item.description == "updated item"
    end

    test "returns errors if invalid" do
      item = insert!(:item, description: "test item")

      assert {:error, changeset} = Todos.update_item(item, %{description: ""})

      assert {"can't be blank", _} = changeset.errors[:description]
    end
  end

  describe "delete_item/1" do
    test "deletes an item" do
      item = insert!(:item, description: "test item")

      assert {:ok, _} = Todos.delete_item(item)
      assert nil == Todos.get_item(item.id)
    end
  end
end
