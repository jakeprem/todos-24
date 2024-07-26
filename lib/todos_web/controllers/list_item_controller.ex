defmodule TodosWeb.ListItemController do
  use TodosWeb, :controller

  alias Todos.Item
  alias Todos.List

  def index(conn, %{"list_id" => list_id}) do
    items = Todos.list_list_items(list_id)

    render(conn, :index, items: items)
  end

  def create(conn, %{"list_id" => list_id, "item" => item_params}) do
    item_params = Map.put(item_params, "list_id", list_id)

    with {:ok, list_id} <- parse_int(list_id),
         # In this case we could just let the foreign key constraint fail if the list doesn't exist
         #  That would save us a database query, but for this simple app I'm choosing consistency with
         # the update logic.
         %List{} <- Todos.get_list(list_id),
         {:ok, item} <- Todos.create_item(item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~s"/api/lists/#{list_id}/items/#{item.id}")
      |> render(:show, item: item)
    end
  end

  def create(conn, _params) do
    render_body_field_error(conn, "item")
  end

  def update(conn, %{"list_id" => list_id, "id" => id, "item" => item_params}) do
    # We should ensure the item is part of the list before updating it. In this
    # simple application, we'd only be violating user expectations by not running this
    # check, but in a real-world application we'd want to do a similar check to make
    # sure all permissions are handled correctly.

    # Doing two separate lookups here because it matches the URL semantics better.
    # Using a preload would still use two queries by default anyway.

    with {:ok, list_id} <- parse_int(list_id),
         %List{} <- Todos.get_list(list_id),
         %Item{list_id: ^list_id} = item <- Todos.get_item(id),
         {:ok, item} <- Todos.update_item(item, item_params) do
      render(conn, :show, item: item)
    end
  end

  def update(conn, _params) do
    render_body_field_error(conn, "item")
  end

  def delete(conn, %{"list_id" => list_id, "id" => id}) do
    with {:ok, list_id} <- parse_int(list_id),
         %List{} <- Todos.get_list(list_id),
         %Item{list_id: ^list_id} = item <- Todos.get_item(id),
         {:ok, _} <- Todos.delete_item(item) do
      send_resp(conn, :no_content, "")
    end
  end

  defp render_body_field_error(conn, expected_field) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(TodosWeb.ErrorJSON)
    |> render("422.json", %{error: "Expected data under the '#{expected_field}' key"})
  end

  defp parse_int(string) do
    case Integer.parse(string) do
      {int, _} -> {:ok, int}
      :error -> nil
    end
  end
end
