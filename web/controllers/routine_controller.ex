defmodule DailyRoutine.RoutineController do
  use DailyRoutine.Web, :controller
  alias DailyRoutine.Routine

  def index(conn, _params) do
    routines = Repo.all Routine
    render conn, "index.html", routines: routines
  end

  def show(conn, %{"id" => id}) do
     routine = Repo.get!(Routine, id)

    render conn, "show.html", routine: routine
  end

  def new(conn, _params) do
    changeset = Routine.changeset()

    render conn, "new.html"
  end

  # def create(conn, %{"routine" => routine_params}) do
  #   changeset = Routine.changeset(routine_params)

  #   case Repo.insert!(changeset) do
  #     {:ok, routine} ->
  #       conn
  #       |> put_flash(:info, "Your routine was successfully created!")
  #       |> redirect(to: routine_path(conn, :index))
  #     {:error, changeset} ->
  #       render conn, "new.html", changeset: changeset
  #   end
  # end
end

