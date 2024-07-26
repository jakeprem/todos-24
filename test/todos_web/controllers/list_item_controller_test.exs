defmodule TodosWeb.ListItemsControllerTest do
  use TodosWeb.ConnCase

  alias Todos.Factory

  describe "index/2" do
    test "lists list items", %{conn: conn} do
      list = Factory.insert!(:list)
      item1 = Factory.insert!(:item, list_id: list.id, description: "test item 1")
      item2 = Factory.insert!(:item, list_id: list.id, description: "test item 2")

      list2 = Factory.insert!(:list, name: "test list 2")
      Factory.insert!(:item, list_id: list2.id, description: "test item 3")

      conn = get(conn, ~p"/api/lists/#{list.id}/items")

      assert json_response(conn, 200) == %{
               "data" => [
                 %{"id" => item1.id, "description" => item1.description, "done" => item1.done},
                 %{"id" => item2.id, "description" => item2.description, "done" => item2.done}
               ]
             }
    end
  end

  describe "create/2" do
    test "creates a list item", %{conn: conn} do
      list = Factory.insert!(:list)

      item_params = %{
        "description" => "test item",
        "done" => false
      }

      conn = post(conn, ~p"/api/lists/#{list.id}/items", %{item: item_params})

      assert %{"data" => %{"id" => item_id, "description" => "test item", "done" => false}} = json_response(conn, 201)
      assert get_resp_header(conn, "location") == ["/api/lists/#{list.id}/items/#{item_id}"]
    end

    test "returns an error when missing a required value", %{conn: conn} do
      list = Factory.insert!(:list)
      conn = post(conn, ~p"/api/lists/#{list.id}/items", %{"item" => %{}})

      assert json_response(conn, 422) == %{
               "errors" => %{
                 "description" => ["can't be blank"]
               }
             }
    end

    test "returns an error when the list does not exist", %{conn: conn} do
      conn = post(conn, ~p"/api/lists/1/items", %{"item" => %{"description" => "test item"}})

      assert json_response(conn, 404) == %{
               "errors" => %{
                 "detail" => "Not Found"
               }
             }
    end
  end

  describe "update/2" do
    test "updates a list item", %{conn: conn} do
      list = Factory.insert!(:list)
      item = Factory.insert!(:item, list_id: list.id, description: "test item")

      conn = put(conn, ~p"/api/lists/#{list.id}/items/#{item.id}", %{"item" => %{"description" => "updated item"}})

      assert json_response(conn, 200) == %{
               "data" => %{
                 "id" => item.id,
                 "description" => "updated item",
                 "done" => item.done
               }
             }
    end

    test "returns an error when the list item does not exist", %{conn: conn} do
      list = Factory.insert!(:list)
      conn = put(conn, ~p"/api/lists/#{list.id}/items/1", %{"item" => %{"description" => "updated item"}})

      assert json_response(conn, 404) == %{
               "errors" => %{
                 "detail" => "Not Found"
               }
             }
    end

    test "returns an error when the list item is not part of the list", %{conn: conn} do
      list = Factory.insert!(:list)
      item = Factory.insert!(:item, description: "test item")

      conn = put(conn, ~p"/api/lists/#{list.id}/items/#{item.id}", %{"item" => %{"description" => "updated item"}})

      assert json_response(conn, 404) == %{
               "errors" => %{
                 "detail" => "Not Found"
               }
             }
    end
  end

  describe "delete/2" do
    test "deletes a list item", %{conn: conn} do
      list = Factory.insert!(:list)
      item = Factory.insert!(:item, list_id: list.id, description: "test item")

      conn = delete(conn, ~p"/api/lists/#{list.id}/items/#{item.id}")

      assert response(conn, 204)
    end

    test "returns an error when the list item does not exist", %{conn: conn} do
      list = Factory.insert!(:list)
      conn = delete(conn, ~p"/api/lists/#{list.id}/items/1")

      assert json_response(conn, 404) == %{
               "errors" => %{
                 "detail" => "Not Found"
               }
             }
    end

    test "returns an error when the list item is not part of the list", %{conn: conn} do
      list = Factory.insert!(:list)
      item = Factory.insert!(:item, description: "test item")

      conn = delete(conn, ~p"/api/lists/#{list.id}/items/#{item.id}")

      assert json_response(conn, 404) == %{
               "errors" => %{
                 "detail" => "Not Found"
               }
             }
    end
  end
end
