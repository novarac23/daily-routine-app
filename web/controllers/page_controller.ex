defmodule DailyRoutine.PageController do
  use DailyRoutine.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
