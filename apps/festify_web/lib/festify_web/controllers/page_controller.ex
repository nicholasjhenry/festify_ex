defmodule FestifyWeb.PageController do
  use FestifyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
