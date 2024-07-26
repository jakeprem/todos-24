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

  def show(conn, %{"id" => id}) do
    with %List{} = list <- Todos.get_list(id) do
      render(conn, :show, list: list)
    end
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    with %List{} = list <- Todos.get_list(id),
         {:ok, list} <- Todos.update_list(list, list_params) do
      render(conn, :show, list: list)
    end
  end

  def delete(conn, %{"id" => id}) do
    with %List{} = list <- Todos.get_list(id),
         {:ok, _} <- Todos.delete_list(list) do
      send_resp(conn, :no_content, "")
    end
  end
end
