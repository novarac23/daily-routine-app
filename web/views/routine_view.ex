defmodule DailyRoutine.RoutineView do
  use DailyRoutine.Web, :view

  def users_name(user) do
    user.username
  end

  def edit_link(conn, routine, user) do
    if conn.assigns.current_user.id == user.id do
      render "edit_link.html", routine: routine, conn: conn
    end
  end

  def delete_button(conn, routine, user) do
    if conn.assigns.current_user.id == user.id do
      render "delete_button.html", routine: routine, conn: conn
    end
  end
end
