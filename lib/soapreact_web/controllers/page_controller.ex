defmodule SoapreactWeb.PageController do
  use SoapreactWeb, :controller

    alias Soapreact.Auth
    alias Soapreact.Auth.User
    alias Soapreact.Auth.Guardian

  # def index(conn, _params) do
  #   render conn, "index.html"
  # end


  def create(conn, %{"user" => %{"email" => user, "password_hash" => password}}) do
      case Soapreact.Auth.authenticate_user(user, password) do
        {:ok, user} ->
          conn
          |> Rumbl.Auth.login(user)
          |> put_flash(:info, "Welcome back!")
          |> redirect(to: user_path(conn, :index))

        {:error, _reason} ->
          conn
          |> put_flash(:error, "Invalid username/password combination")
          |> render("new.html")
      end
    end

    def delete(conn, _) do
      conn
      |> Soapreact.Auth.logout()
      |> redirect(to: page_path(conn, :index))
    end


  def index(conn, _params) do
    changeset = Auth.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    message=if maybe_user != nil do
      "someone is logged in"
    else
      "no one is logged in"
    end

    conn
    |> put_flash(:info, message)
    |> render("index.html", changeset: changeset, action: page_path(conn, :login), maybe_user: maybe_user)

  end


    def login(conn, %{"user" => %{"email" => email, "password_hash" => password_hash}}) do
      Auth.authenticate_user(email, password_hash)
      |> login_reply(conn)
    end

  defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/")
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: page_path(conn, :login))
  end

  def secret(conn, _params) do
    render(conn, "index.html")
  end

end
