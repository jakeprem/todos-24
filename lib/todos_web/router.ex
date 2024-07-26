defmodule TodosWeb.Router do
  use TodosWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodosWeb do
    pipe_through :api

    resources "/lists", ListController, except: [:new, :edit] do
      resources "/items", ListItemController, except: [:new, :edit]
    end
  end
end
