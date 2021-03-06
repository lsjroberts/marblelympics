defmodule Marbles.Repo.Migrations.CreateMarbles do
  use Ecto.Migration

  def change do
    create table(:marbles) do
      add(:name, :string)
      add(:team_id, references(:teams))

      timestamps()
    end
  end
end
