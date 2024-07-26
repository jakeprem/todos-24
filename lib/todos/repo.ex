defmodule Todos.Repo do
  use Ecto.Repo,
    otp_app: :todos,
    adapter: Ecto.Adapters.SQLite3

  @doc """
  Insert a changeset into the database, handling constraint errors.

  Turns out SQLite doesn't return the name of the constraint that was violated,
  so :ecto_sqlite3 just returns nil. Might be possible to use the options
  of `Ecto.Changeset.foreign_key_constraint/3` to get it to match on nil but I've been unsuccessful
  so far.
  """
  def safe_insert(changeset, opts \\ []) do
    insert(changeset, opts)
  rescue
    e in Ecto.ConstraintError ->
      handle_foreign_key_constraints(changeset, e)
  end

  @doc """
  Update a changeset in the database, handling constraint errors.

  See `safe_insert/2` for more information.
  """
  def safe_update(changeset, opts \\ []) do
    update(changeset, opts)
  rescue
    e in Ecto.ConstraintError ->
      handle_foreign_key_constraints(changeset, e)
  end

  defp handle_foreign_key_constraints(%Ecto.Changeset{} = changeset, e) do
    %{constraints: constraints} = changeset
    foreign_key_constraints = Enum.filter(constraints, &(&1.type == :foreign_key))

    if e.type == :foreign_key and foreign_key_constraints != [] do
      # if we wanted to get really in the weeds we could do some introspection on the schema or the database to determine
      # if there's only a single foreign key but that effort might be better spent looking for a way to fix the bug
      error_changeset =
        Enum.reduce(foreign_key_constraints, changeset, fn constraint, changeset ->
          Ecto.Changeset.add_error(
            changeset,
            constraint.field,
            "may not exist (SQLite raised a foreign key constraint error but does not specify which one)"
          )
        end)

      {:error, error_changeset}
    else
      raise e
    end
  end
end
