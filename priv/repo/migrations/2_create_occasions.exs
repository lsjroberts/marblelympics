defmodule Marbles.Repo.Migrations.CreateOccasions do
  use Ecto.Migration

  def change do
    create table(:occasions) do
      add :name, :string

      timestamps()
    end

  end
end
