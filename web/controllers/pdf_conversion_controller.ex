defmodule DailyRoutine.PdfConversionController do
  use DailyRoutine.Web, :controller


  def create(conn, %{"routine_id" => routine_id, "routine" => routine_params}, user) do
    routine = Repo.get!(DailyRoutine.Routine, routine_id) |> Repo.preload(:user)

    case routine do
      {:ok, routine} ->
        #TODO
        # spawn a task and return :ok
        task = Task.async(fn -> generate_pdf(routine, user) end)
        result = Task.await(task)

        redirect(conn, to: routine_path(conn, :index))
      {_} ->
        #TODO
        # spawn a task and return :ok
        redirect(conn, to: routine_path(conn, :index))
    end
  end

  def generate_pdf(routine, user) do
    2 * 2
  end
end
