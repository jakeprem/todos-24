defmodule TodosWeb.ListControllerTest do
  use TodosWeb.ConnCase

  describe "index/2" do
    test "lists lists", %{conn: conn} do
      list1 = insert!(:list, name: "test list 1")
      list2 = insert!(:list, name: "test list 2")

      conn = get(conn, ~p"/api/lists")

      assert json_response(conn, 200) == %{
               "data" => [
                 %{
                   "id" => list1.id,
                   "name" => list1.name,
                   "createdAt" => format_datetime(list1.inserted_at),
                   "updatedAt" => format_datetime(list1.updated_at)
                 },
                 %{
                   "id" => list2.id,
                   "name" => list2.name,
                   "createdAt" => format_datetime(list2.inserted_at),
                   "updatedAt" => format_datetime(list2.updated_at)
                 }
               ]
             }
    end
  end

  describe "create/2" do
    test "creates a list", %{conn: conn} do
      list_params = %{
        "name" => "test list"
      }

      conn = post(conn, ~p"/api/lists", %{list: list_params})

      assert %{"data" => %{"id" => list_id, "name" => "test list"}} = json_response(conn, 201)
      assert get_resp_header(conn, "location") == ["/api/lists/#{list_id}"]
    end

    test "returns an error when missing a required value", %{conn: conn} do
      conn = post(conn, ~p"/api/lists", %{"list" => %{}})

      assert json_response(conn, 422) == %{
               "errors" => %{
                 "name" => ["can't be blank"]
               }
             }
    end
  end

  describe "show/2" do
    test "shows a list", %{conn: conn} do
      list = insert!(:list, name: "test list")

      conn = get(conn, ~s"/api/lists/#{list.id}")

      assert json_response(conn, 200) == %{
               "data" => %{
                 "id" => list.id,
                 "name" => list.name,
                 "createdAt" => format_datetime(list.inserted_at),
                 "updatedAt" => format_datetime(list.updated_at)
               }
             }
    end

    test "returns an error when the list does not exist", %{conn: conn} do
      conn = get(conn, ~s"/api/lists/1")

      assert json_response(conn, 404) == %{
               "errors" => %{
                 "detail" => "Not Found"
               }
             }
    end
  end

  describe "update/2" do
    test "updates a list", %{conn: conn} do
      list = insert!(:list, name: "test list")

      conn = put(conn, ~s"/api/lists/#{list.id}", %{"list" => %{"name" => "updated list"}})

      assert result = json_response(conn, 200)

      assert result == %{
               "data" => %{
                 "id" => list.id,
                 "name" => "updated list",
                 "createdAt" => format_datetime(list.inserted_at),
                 "updatedAt" => result["data"]["updatedAt"]
               }
             }
    end

    test "returns an error when the list does not exist", %{conn: conn} do
      conn = put(conn, ~s"/api/lists/1", %{"list" => %{"name" => "updated list"}})

      assert json_response(conn, 404) == %{
               "errors" => %{
                 "detail" => "Not Found"
               }
             }
    end

    test "returns an error when missing a required value", %{conn: conn} do
      list = insert!(:list, name: "test list")

      conn = put(conn, ~s"/api/lists/#{list.id}", %{"list" => %{"name" => ""}})

      assert json_response(conn, 422) == %{
               "errors" => %{
                 "name" => ["can't be blank"]
               }
             }
    end
  end

  describe "delete/2" do
    test "deletes a list", %{conn: conn} do
      list = insert!(:list, name: "test list")

      conn = delete(conn, ~s"/api/lists/#{list.id}")

      assert response(conn, 204)
    end

    test "returns an error when the list does not exist", %{conn: conn} do
      conn = delete(conn, ~s"/api/lists/1")

      assert json_response(conn, 404) == %{
               "errors" => %{
                 "detail" => "Not Found"
               }
             }
    end
  end

  defp format_datetime(%NaiveDateTime{} = datetime) do
    NaiveDateTime.to_iso8601(datetime)
  end
end
