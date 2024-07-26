# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Todos.Repo.insert!(%Todos.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Todos.Repo

# For performance we could use bulk inserts here
todo_lists =
  for idx <- 1..3 do
    Repo.insert!(%Todos.List{name: "List #{idx}"})
  end

for list <- todo_lists, idx <- 1..5 do
  Repo.insert!(%Todos.Item{description: "Do the thing #{idx}", list_id: list.id, done: rem(idx, 2) == 0})
end
