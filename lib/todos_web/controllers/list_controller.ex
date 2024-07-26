defmodule TodosWeb.ListController do
  use TodosWeb, :controller

  alias Todos.List
  alias Todos.Repo

  def index(conn, _params) do
    lists = Repo.all(List)
    render(conn, :index, lists: lists)
  end

  def create(conn, %{"list" => list_params}) do
    with {:ok, list} <- Todos.create_list(list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/lists/#{list.id}")
      |> render(:show, list: list)
    end
  end

  # list key is part of the user submitted data, so we should
  # have a fallback if they pass a bad format
  def create(conn, _params) do
    render_body_field_error(conn, "list")
  end

  # id is a path param so no need for a fallback option here
  def show(conn, %{"id" => id}) do
    with {:ok, id} <- parse_int(id),
         %List{} = list <- Todos.get_list(id) do
      render(conn, :show, list: list)
    end
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    with {:ok, id} <- parse_int(id),
         %List{} = list <- Todos.get_list(id),
         {:ok, list} <- Todos.update_list(list, list_params) do
      render(conn, :show, list: list)
    end
  end

  def update(conn, _params) do
    render_body_field_error(conn, "list")
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, id} <- parse_int(id),
         %List{} = list <- Todos.get_list(id),
         {:ok, _} <- Todos.delete_list(list) do
      send_resp(conn, :no_content, "")
    end
  end

  # Should probably stick this on the Fallback controller instead and just call that where needed
  defp render_body_field_error(conn, expected_field) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(TodosWeb.ErrorJSON)
    |> render("422.json", %{error: "Expected data under the '#{expected_field}' key"})
  end

  # I have this in two files. It should be in a Utils module,
  # or potentially we could just use Integer.parse directly
  # but this makes it a bit easier to control the return values

  # Also rather than nil -> 404 we should probably return a detailed
  # error message indicating that an invalid id was passed
  defp parse_int(string) do
    case Integer.parse(string) do
      {int, _} -> {:ok, int}
      :error -> nil
    end
  end
end
