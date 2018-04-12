defmodule SoapreactWeb.Router do
  use SoapreactWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SoapreactWeb do
    pipe_through :browser # Use the default browser stack

    # get "/users", UserController, :index
    # get "/users/:id", UserController, :show


    get "/", PageController, :index
    resources "/posts", PostController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SoapreactWeb do
  #   pipe_through :api
  # end
end
