defmodule TodosWeb.ChangesetJSON do
  alias Ecto.Changeset

  def error(%{changeset: %Changeset{} = changeset}) do
    # I feel like there's a simpler way to do this but this works for now
    errors = Ecto.Changeset.traverse_errors(changeset, &elem(&1, 0))

    %{errors: errors}
  end
end
