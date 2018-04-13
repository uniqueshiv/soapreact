defmodule Soapreact.Auth.Guardian do
  use Guardian, otp_app: :soapreact

  alias Soapreact.Auth

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end



  def resource_from_claims(claims) do
      # user = claims["sub"]
      # |> Auth.get_user!
      # {:ok, user}

    id = claims["sub"]
     user = Auth.get_user(id)
     {:ok, user}
      # If something goes wrong here return {:error, reason}
  end


end
