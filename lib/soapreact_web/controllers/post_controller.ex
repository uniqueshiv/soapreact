defmodule SoapreactWeb.PostController do
  use SoapreactWeb, :controller

  def posts(conn, _params) do
    render conn, "index.html"
  end

end
