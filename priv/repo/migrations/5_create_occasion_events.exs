defmodule Marbles.Repo.Migrations.CreateOccasionEvents do
  use Ecto.Migration

  def change do
    create table(:occasion_events) do
      add(:occasion_id, references(:occasions, on_delete: :delete_all), primary_key: true)
      add(:event_id, references(:events, on_delete: :delete_all), primary_key: true)
      add(:date, :date)
    end

    create(index(:occasion_events, [:occasion_id]))
    create(index(:occasion_events, [:event_id]))

    create(
      unique_index(:occasion_events, [:event_id, :occasion_id],
        name: :event_id_occasion_id_unique_index
      )
    )
  end
end
