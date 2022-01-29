defmodule Exmeal.Repo.Migrations.CreateMealsTable do
  use Ecto.Migration

  def change do
    create table("meal") do
      add :description, :string
      add :date, :utc_datetime
      add :calories, :float

      timestamps()
    end
  end
end
