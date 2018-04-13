defmodule SoapreactWeb.Router do
  use SoapreactWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug Soapreact.Auth.Pipeline
  end
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end


  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SoapreactWeb do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/", PageController, :index
    resources "/posts", PostController
    resources "/users", UserController
    post "/", PageController, :login
    post "/logout", PageController, :logout

  end


  scope "/", AuthExWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    
    get "/secret", PageController, :secret
  end

  # Other scopes may use custom stacks.
  # scope "/api", SoapreactWeb do
  #   pipe_through :api
  # end
end
