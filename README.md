# Todos

## Running the code

The backend runs as a completely standard Phoenix application. I'm using SQLite as the database so nothing extra should be required.

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000/api`](http://localhost:4000/api) from your browser or call it from your application

## Functional Requirements

- [x] As a user, I can create a todo list;
- [x] As a user, I can add a todo item;
- [x] As a user, I can view the items on the todo list;
- [x] As a user, I can check the item in the list, and mark it as done;
- [x] As a user, I can remove an item from the list.

## REST Endpoints

| Path                                      | Description                         | Implemented?                      | (Strictly) Required? |
| ----------------------------------------- | ----------------------------------- | --------------------------------- | -------------------- |
| `GET /api/lists`                          | Returns all todo lists              | ✅                                |                      |
| `POST /api/lists`                         | Create a new todo list              | ✅                                | ✅                   |
| `GET /api/lists/:id`                      | Gets a todo list                    | ✅                                |                      |
| `PUT /api/lists/:id`                      | Update an item in the list          | ✅                                |                      |
| `DELETE /api/lists/:id`                   | Delete a todo list                  | ✅                                |                      |
| `GET /api/lists/:id/items`                | Get the items in a todo list        | ✅                                | ✅                   |
| `POST /api/lists/:id/items`               | Create a new item in the given list | ✅                                | ✅                   |
| `PUT /api/lists/:id/items/:item_id`       | Update an item in a todo list       | ✅                                |                      |
| `POST /api/lists/:id/items/:item_id/done` | Mark an item as done                | Deferred to just updating an item | ✅                   |
| `DELETE /api/lists/:id/items/:item_id`    | Delete the given item               | ✅                                | ✅                   |

I tried to match relatively standard routes for a typical REST API you might see implemented in Phoenix or Rails. Endpoints that take in extraneous ids,
like `PUT /api/lists/:id/items/:item_id` always feel a bit weird to me but I went that way to keep things consistent (rather than creating flattened endpoints like `PUT/api/items/:item_id`).

## Notes

### Authentication

For this simple app I decided to skip adding auth and users.
A production app would need to handle user authentication and provide some kind of authorization model so that users
can only edit their own TODO lists and items. A slightly more sophisticated approach might also include teams or organizations.

Auth options:

- JWTs or tokens: For looser coupling between the frontend and the API deployments
- Cookies: If serving the API and frontend from the same domain cookies can be way simpler than managing the token ourselves

### Database

SQLite can take you quite far, but in most real world use-cases I'd still use PostgresSQL. For example in this project I had to work around a limitation in how SQLite handles foreign key constraints, and in general Postgres offers a lot of nice scaling options.

### Pagination, Filtering, etc.

Didn't add any pagination here either since it wasn't in the requirements but that's probably the next thing to add, probably right after auth. Would lean towards cursor based unless requirements specfically called for offset.

### Error Handling

Everything should have decent error handling. In some cases the status codes might not match exactly what you'd want in your production API, but that's also somewhat project specific. I'm generally returning 404s if any required record is missing and 422s for any mutations that are otherwise missing parameters.

### Git History

Not as clean as it could be, most of the commits have more/broader changes than you'd typically want if you were being really disciplined about it.

### OpenAPI Spec

I generated the OpenAPI spec and made a few manual tweaks. It should be accurate and you should be able to copy or load it into any Swagger UI (such as https://editor-next.swagger.io/) and execute queries against your locally running API. CORs is configured to be permissive when running in dev.

Also looking at this it looks like I missed adding required fields, so if you were to generate an API client off of this spec you'd be dealing with lots of extra nullable fields in your types. That's something that should be fixed before generating a frontend i.e. Typescript client.

### React UI

You should be able to run this from the `frontend` directory with a simple `npm install` and `npm start`, then go to [`localhost:3000`](http://localhost:3000)

Since building the UI wasn't part of the requirements I opted to generate this as well,
mainly just as another way to test the API.
