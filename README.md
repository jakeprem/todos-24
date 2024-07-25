# App

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Functional Requirements

- As a user, I can create a todo list;
- As a user, I can add a todo item;
- As a user, I can view the items on the todo list;
- As a user, I can check the item in the list, and mark it as done;
- As a user, I can remove an item from the list.

## REST Endpoints

| Path                                  | Description                         | Implemented? | (Strictly) Required? |
| ------------------------------------- | ----------------------------------- | ------------ | -------------------- |
| `GET /lists`                          | Returns all todo lists              |              |                      |
| `POST /lists`                         | Create a new todo list              |              | ✅                   |
| `GET /lists/:id`                      | Gets a todo list                    |              |                      |
| `PUT /lists/:id`                      | Update an item in the list          |              |                      |
| `DELETE /lists/:id`                   | Delete a todo list                  |              |                      |
| `GET /lists/:id/items`                | Get the items in a todo list        |              | ✅                   |
| `POST /lists/:id/items`               | Create a new item in the given list |              | ✅                   |
| `POST /lists/:id/items/:item_id/done` | Mark an item as done                |              | ✅                   |
| `PUT /lists/:id/items/:item_id`       | Update an item in a todo list       |              |                      |
| `DELETE /lists/:id/items/:item_id`    | Delete the given item               |              | ✅                   |
