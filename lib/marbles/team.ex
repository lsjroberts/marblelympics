defmodule Marbles.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field(:name, :string)
    has_many(:marbles, Marbles.Marble)
    many_to_many(:occasions, Marbles.Occasion, join_through: "occasion_teams")
    many_to_many(:competitors, Marbles.Competitor, join_through: "competitors")

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
