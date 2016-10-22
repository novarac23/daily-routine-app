defmodule DailyRoutine.Router do
  use DailyRoutine.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DailyRoutine.Auth, repo: DailyRoutine.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DailyRoutine do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/sign-up", UserController, :new
    resources "/users", UserController, only: [:create]

    get "/log-in", SessionController, :new
    resources "/sessions", SessionController, only: [:create, :delete]
  end

  scope "/app", DailyRoutine do
    pipe_through [:browser, :authenticate_user]

    resources "/routines", RoutineController do
      resources "/comments", CommentController, only: [:create, :delete]
      resources "/pdf_conversions", PdfConversionController, only: [:create]
    end
  end
end
