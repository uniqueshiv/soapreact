defmodule SoapreactWeb.UserController do
  use SoapreactWeb, :controller

  alias Soapreact.Accounts
  alias Soapreact.Accounts.User


  # def index(conn, _params) do
  #   users = Accounts.list_users()
  #   render(conn, "index.html", users: users)
  # end

  def index(conn, params) do
    users = Accounts.list_users()
    # users= User
    #   |>Repo.paginate(params)

    render(conn, "index.html", users: users)
  end
  # def index(conn, _params) do
  #   page =
  #     Accounts.User
  #     #|> where([p], p.age > 30)
  #     |> order_by(desc: :id)
  #     # |> preload(:friends)
  #     |>Accounts.Repo.paginate(params)
  #
  #   render conn, :index,
  #     people: page.entries,
  #     page_number: page.page_number,
  #     page_size: page.page_size,
  #     total_pages: page.total_pages,
  #     total_entries: page.total_entries
  # end
  # def index(conn, params) do
  #   page=User
  #   |> Repo.paginate(params)
  #   render(conn, "index.html", users: page.entries, page: page)
  #
  # end



  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
