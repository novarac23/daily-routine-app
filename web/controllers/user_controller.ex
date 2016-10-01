defmodule DailyRoutine.UserController do
  use DailyRoutine.Web, :controller
  alias DailyRoutine.User

  def new(conn, _params) do
    changeset = User.registration_changeset(%User{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> DailyRoutine.Auth.login(user)
        |> put_flash(:info, "Your account has successfully been created!")
        |> redirect(to: routine_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
