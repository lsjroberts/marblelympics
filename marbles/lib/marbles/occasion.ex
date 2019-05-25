defmodule Marbles.Occasion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "occasions" do
    field(:name, :string)
    many_to_many(:events, Marbles.Event, join_through: "occasion_events")
    many_to_many(:teams, Marbles.Team, join_through: "occasion_teams")
    many_to_many(:competitors, Marbles.Competitor, join_through: "competitors")

    timestamps()
  end

  @doc false
  def changeset(occasion, attrs) do
    occasion
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
