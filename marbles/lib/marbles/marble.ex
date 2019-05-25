defmodule Marbles.Marble do
  use Ecto.Schema
  import Ecto.Changeset

  schema "marbles" do
    field(:name, :string)
    belongs_to(:team, Marbles.Team)
    many_to_many(:competitors, Marbles.Competitor, join_through: "competitors")

    timestamps()
  end

  @doc false
  def changeset(marble, attrs) do
    marble
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
