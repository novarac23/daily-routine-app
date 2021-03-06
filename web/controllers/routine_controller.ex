defmodule DailyRoutine.RoutineController do
  use DailyRoutine.Web, :controller
  alias DailyRoutine.Routine
  alias DailyRoutine.Comment

  def index(conn, _params, user) do
    routines = Repo.all(Routine) |> Repo.preload(:user)
    render conn, "index.html", routines: routines
  end

  def show(conn, %{"id" => id}, user) do
    routine =
      Repo.get!(Routine, id)
      |> Repo.preload(:user)

    comments =
      Comment.query_comments(Comment, id)
      |> Repo.all()

    changeset = Comment.changeset(%Comment{})

    render conn, "show.html", changeset: changeset, routine: routine, comments: comments
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:routines)
      |> Routine.changeset()

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"routine" => routine_params}, user) do
    changeset =
      user
      |> build_assoc(:routines)
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

  def edit(conn, %{"id" => id}, user) do
    routine = Repo.get!(user_routines(user), id) |> Repo.preload(:user)
    changeset = Routine.changeset(routine)
    render conn, "edit.html", routine: routine, changeset: changeset
  end

  def update(conn, %{"id" => id, "routine" => routine_params}, user) do
    routine = Repo.get!(user_routines(user), id)
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

  def delete(conn, %{"id" => id}, user) do
    routine = Repo.get(user_routines(user), id)

    Repo.delete!(routine)

    conn
		|> put_flash(:info, "Routine deleted successfully.")
		|> redirect(to: routine_path(conn, :index))
  end

  def user_routines(user) do
    assoc(user, :routines)
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end
end

