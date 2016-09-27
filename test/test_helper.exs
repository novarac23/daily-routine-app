ExUnit.start

Mix.Task.run "ecto.create", ~w(-r DailyRoutine.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r DailyRoutine.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(DailyRoutine.Repo)

