defmodule Marbles.Repo.Migrations.CreateCompetitors do
  use Ecto.Migration

  def change do
    create table(:competitors) do
      add(:occasion_id, references(:occasions, on_delete: :delete_all), primary_key: true)
      add(:event_id, references(:events, on_delete: :delete_all), primary_key: true)
      add(:team_id, references(:teams, on_delete: :delete_all), primary_key: true)
      add(:marble_id, references(:marbles, on_delete: :delete_all), primary_key: true)
      add(:score, {:array, :integer})
      add(:points, :integer)

      timestamps()
    end

    create(index(:competitors, [:occasion_id]))
    create(index(:competitors, [:event_id]))
    create(index(:competitors, [:team_id]))
    create(index(:competitors, [:marble_id]))

    create(
      unique_index(:competitors, [:marble_id, :team_id, :event_id, :occasion_id],
        name: :marble_id_team_id_event_id_occasion_id_unique_index
      )
    )
  end
end
