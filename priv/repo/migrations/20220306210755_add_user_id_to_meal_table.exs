defmodule Exmeal.Repo.Migrations.AddUserIdToMealTable do
  use Ecto.Migration

  def change do
    alter table("meal") do
      add :user_id, references(:user)
    end
  end
end
