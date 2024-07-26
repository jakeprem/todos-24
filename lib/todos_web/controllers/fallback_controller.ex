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

  # We'll treat all unexpected returned values as 404s.
  # This might be unwise in a production app, but for this one
  # it lets us simply pass through records that don't match guards
  # e.g. if a user tries to update an item that's not part of their current list.

  # As long as the app doesn't raise an error the user will at least get something back.
  def call(conn, _) do
    conn
    |> put_status(:not_found)
    |> put_view(TodosWeb.ErrorJSON)
    |> render("404.json")
  end
end
