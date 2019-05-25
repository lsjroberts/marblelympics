defmodule Marbles.Repo.Migrations.CreateOccasionTeams do
  use Ecto.Migration

  def change do
    create table(:occasion_teams) do
      add(:occasion_id, references(:occasions, on_delete: :delete_all), primary_key: true)
      add(:team_id, references(:teams, on_delete: :delete_all), primary_key: true)
    end

    create(index(:occasion_teams, [:occasion_id]))
    create(index(:occasion_teams, [:team_id]))

    create(
      unique_index(:occasion_teams, [:team_id, :occasion_id],
        name: :team_id_occasion_id_unique_index
      )
    )
  end
end
