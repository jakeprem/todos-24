defmodule TodosWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(TodosWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, nil) do
    conn
    |> put_status(:not_found)
    |> put_view(TodosWeb.ErrorJSON)
    |> render("404.json")
  end
end
