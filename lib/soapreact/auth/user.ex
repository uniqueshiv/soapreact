defmodule Soapreact.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :is_admin, :boolean, default: false
    field :name, :string
    field :password_hash, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :phone, :password_hash, :is_admin])
    |> validate_required([:email, :name, :password_hash])
    |> validate_changeset
    #|> put_pass_hash
  end

  defp validate_changeset(struct) do
      struct
      |> validate_length(:email, min: 5, max: 255)
      |> validate_format(:email, ~r/@/)
      |> unique_constraint(:email)
      |> validate_length(:password_hash, min: 8)
      |> validate_format(:password_hash, ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*/, [message: "Must include at least one lowercase letter, one uppercase letter, and one digit"])
      |> generate_password_hash()
    end

    defp generate_password_hash(changeset) do
      case changeset do
        %Ecto.Changeset{valid?: true, changes: %{password_hash: password_hash}} ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password_hash))
        _ ->
          changeset
      end
    end

  # defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password_hash: password}} = changeset) do
  #   change(changeset, password_hash: Bcrypt.hashpwsalt(password))
  # end


  #defp put_pass_hash(changeset), do: changeset


end
