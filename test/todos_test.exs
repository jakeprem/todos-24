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
end
