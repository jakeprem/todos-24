# Todos API

> Version 1.0.0

API for managing todo lists and items

## Path Table

| Method | Path | Description |
| --- | --- | --- |
| GET | [/api/lists](#getapilists) | List all todo lists |
| POST | [/api/lists](#postapilists) | Create a new todo list |
| DELETE | [/api/lists/{listId}](#deleteapilistslistid) | Delete a todo list |
| GET | [/api/lists/{listId}](#getapilistslistid) | Get a specific todo list |
| PUT | [/api/lists/{listId}](#putapilistslistid) | Update a todo list |
| GET | [/api/lists/{listId}/items](#getapilistslistiditems) | List all items in a todo list |
| POST | [/api/lists/{listId}/items](#postapilistslistiditems) | Create a new item in a todo list |
| DELETE | [/api/lists/{listId}/items/{itemId}](#deleteapilistslistiditemsitemid) | Delete an item from a todo list |
| PUT | [/api/lists/{listId}/items/{itemId}](#putapilistslistiditemsitemid) | Update an item in a todo list |

## Reference Table

| Name | Path | Description |
| --- | --- | --- |
| ErrorResponse | [#/components/schemas/ErrorResponse](#componentsschemaserrorresponse) |  |
| Item | [#/components/schemas/Item](#componentsschemasitem) |  |
| ItemInput | [#/components/schemas/ItemInput](#componentsschemasiteminput) |  |
| ItemResponse | [#/components/schemas/ItemResponse](#componentsschemasitemresponse) |  |
| ItemsResponse | [#/components/schemas/ItemsResponse](#componentsschemasitemsresponse) |  |
| List | [#/components/schemas/List](#componentsschemaslist) |  |
| ListInput | [#/components/schemas/ListInput](#componentsschemaslistinput) |  |
| ListResponse | [#/components/schemas/ListResponse](#componentsschemaslistresponse) |  |
| ListsResponse | [#/components/schemas/ListsResponse](#componentsschemaslistsresponse) |  |

## Path Details

***

### [GET]/api/lists

- Summary  
List all todo lists

#### Responses

- 200 Successful response

`application/json`

```ts
{
  data: {
    id?: integer
    name?: string
    updatedAt?: string
    createdAt?: string
  }[]
}
```

***

### [POST]/api/lists

- Summary  
Create a new todo list

#### RequestBody

- application/json

```ts
{
  list: {
    name: string
  }
}
```

#### Responses

- 201 Created

`application/json`

```ts
{
  data: {
    id?: integer
    name?: string
    updatedAt?: string
    createdAt?: string
  }
}
```

- 422 Unprocessable Entity

`application/json`

```ts
{
  errors: {
  }
}
```

***

### [DELETE]/api/lists/{listId}

- Summary  
Delete a todo list

#### Responses

- 204 No Content

- 404 Not Found

`application/json`

```ts
{
  errors: {
  }
}
```

***

### [GET]/api/lists/{listId}

- Summary  
Get a specific todo list

#### Responses

- 200 Successful response

`application/json`

```ts
{
  data: {
    id?: integer
    name?: string
    updatedAt?: string
    createdAt?: string
  }
}
```

- 404 Not Found

`application/json`

```ts
{
  errors: {
  }
}
```

***

### [PUT]/api/lists/{listId}

- Summary  
Update a todo list

#### RequestBody

- application/json

```ts
{
  list: {
    name: string
  }
}
```

#### Responses

- 200 Successful response

`application/json`

```ts
{
  data: {
    id?: integer
    name?: string
    updatedAt?: string
    createdAt?: string
  }
}
```

- 404 Not Found

`application/json`

```ts
{
  errors: {
  }
}
```

- 422 Unprocessable Entity

`application/json`

```ts
{
  errors: {
  }
}
```

***

### [GET]/api/lists/{listId}/items

- Summary  
List all items in a todo list

#### Responses

- 200 Successful response

`application/json`

```ts
{
  data: {
    id?: integer
    listId?: integer
    description?: string
    done?: boolean
    updatedAt?: string
    createdAt?: string
  }[]
}
```

***

### [POST]/api/lists/{listId}/items

- Summary  
Create a new item in a todo list

#### RequestBody

- application/json

```ts
{
  item: {
    description: string
    done?: boolean
  }
}
```

#### Responses

- 201 Created

`application/json`

```ts
{
  data: {
    id?: integer
    listId?: integer
    description?: string
    done?: boolean
    updatedAt?: string
    createdAt?: string
  }
}
```

- 422 Unprocessable Entity

`application/json`

```ts
{
  errors: {
  }
}
```

***

### [DELETE]/api/lists/{listId}/items/{itemId}

- Summary  
Delete an item from a todo list

#### Responses

- 204 No Content

- 404 Not Found

`application/json`

```ts
{
  errors: {
  }
}
```

***

### [PUT]/api/lists/{listId}/items/{itemId}

- Summary  
Update an item in a todo list

#### RequestBody

- application/json

```ts
{
  item: {
    description: string
    done?: boolean
  }
}
```

#### Responses

- 200 Successful response

`application/json`

```ts
{
  data: {
    id?: integer
    listId?: integer
    description?: string
    done?: boolean
    updatedAt?: string
    createdAt?: string
  }
}
```

- 404 Not Found

`application/json`

```ts
{
  errors: {
  }
}
```

## References

### #/components/schemas/ErrorResponse

```ts
{
  errors: {
  }
}
```

### #/components/schemas/Item

```ts
{
  id?: integer
  listId?: integer
  description?: string
  done?: boolean
  updatedAt?: string
  createdAt?: string
}
```

### #/components/schemas/ItemInput

```ts
{
  description: string
  done?: boolean
}
```

### #/components/schemas/ItemResponse

```ts
{
  data: {
    id?: integer
    listId?: integer
    description?: string
    done?: boolean
    updatedAt?: string
    createdAt?: string
  }
}
```

### #/components/schemas/ItemsResponse

```ts
{
  data: {
    id?: integer
    listId?: integer
    description?: string
    done?: boolean
    updatedAt?: string
    createdAt?: string
  }[]
}
```

### #/components/schemas/List

```ts
{
  id?: integer
  name?: string
  updatedAt?: string
  createdAt?: string
}
```

### #/components/schemas/ListInput

```ts
{
  name: string
}
```

### #/components/schemas/ListResponse

```ts
{
  data: {
    id?: integer
    name?: string
    updatedAt?: string
    createdAt?: string
  }
}
```

### #/components/schemas/ListsResponse

```ts
{
  data: {
    id?: integer
    name?: string
    updatedAt?: string
    createdAt?: string
  }[]
}
```