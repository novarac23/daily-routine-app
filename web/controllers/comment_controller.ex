defmodule DailyRoutine.CommentController do
  use DailyRoutine.Web, :controller
  alias DailyRoutine.Comment

  def create(conn, %{"routine_id" => routine_id, "comment" => comment_params}, user) do
    routine = Repo.get!(DailyRoutine.Routine, routine_id) |> Repo.preload(:user)

    comment_params =
      comment_params
      |> Map.put("user_id", user.id)
      |> Map.put("routine_id", routine.id)

    changeset = Comment.changeset(%Comment{}, comment_params)

    case Repo.insert(changeset) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Your comment was successfully posted!")
        |> redirect(to: routine_path(conn, :show, routine_id))
      {:error, changeset} ->
        redirect(conn, to: routine_path(conn, :show, routine_id))
    end
  end

  def delete(conn, %{"routine_id" => routine_id, "id" => id}, user) do
    comment = Repo.get(user_comments(user), id)

    Repo.delete!(comment)

    conn
		|> put_flash(:info, "Comment deleted!")
		|> redirect(to: routine_path(conn, :show, routine_id))
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def user_comments(user) do
    assoc(user, :comments)
  end
end

