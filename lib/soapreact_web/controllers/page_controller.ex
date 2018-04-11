defmodule SoapreactWeb.PageController do
  use SoapreactWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
