defmodule FestifyPromotionWeb.PageController do
  use FestifyPromotionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
