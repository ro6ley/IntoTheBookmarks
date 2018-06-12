defmodule IntoTheBookmarks.Router do
  use IntoTheBookmarks.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", IntoTheBookmarks do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
  end
end
