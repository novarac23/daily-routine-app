defmodule DailyRoutine.RoutineController do
  use DailyRoutine.Web, :controller
  alias DailyRoutine.Routine

  plug :scrub_params, "routines" when action in [:create, :update]

  def index(conn, _params, user) do
    routines = Repo.all(user_videos(user))
    render conn, "index.html", routines: routines
  end

  def show(conn, %{"id" => id}) do
     routine = Repo.get!(Routine, id)

    render conn, "show.html", routine: routine
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:resources)
      |> Routine.changeset()

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"routine" => routine_params}, user) do
    changeset =
      user
      |> build_assoc(:resources)
      |> Routine.changeset(routine_params)

    case Repo.insert(changeset) do
      {:ok, routine} ->
        conn
        |> put_flash(:info, "Your routine was successfully created!")
        |> redirect(to: routine_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    routine = Repo.get!(Routine, id)
    changeset = Routine.changeset(routine)
    render conn, "edit.html", routine: routine, changeset: changeset
  end

  def update(conn, %{"id" => id, "routine" => routine_params}) do
    routine = Repo.get!(Routine, id)
    changeset = Routine.changeset(routine, routine_params)

    case Repo.update(changeset) do
      {:ok, routine} ->
        conn
        |> put_flash(:info, "Your routine was successfully created!")
        |> redirect(to: routine_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end

  end


  def delete(conn, %{"id" => id}) do
    routine = Repo.get(Routine, id)

    Repo.delete!(routine)

    conn
		|> put_flash(:info, "Routine deleted successfully.")
		|> redirect(to: routine_path(conn, :index))
  end

  def user_routines(user) do
    assoc(user, :routines)
  end
end

