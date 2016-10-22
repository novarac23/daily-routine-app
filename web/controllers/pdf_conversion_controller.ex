defmodule DailyRoutine.PdfConversionController do
  use DailyRoutine.Web, :controller

  def create(conn, %{"routine_id" => routine_id}, user) do
    routine = Repo.get!(DailyRoutine.Routine, routine_id) |> Repo.preload(:user)
    task = Task.async(fn -> generate_pdf(routine, user) end)
    result = Task.await(task)
    redirect(conn, to: routine_path(conn, :show, routine_id))

    # TODO
    # Do checking based on if the results exists or not
  end

  def generate_pdf(routine, user) do
    2 * 2
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end
end
