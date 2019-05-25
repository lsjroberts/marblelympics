defmodule Marbles.Competitor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "competitors" do
    field(:score, {:array, :integer})
    field(:points, :integer)
    belongs_to(:occasion, Marbles.Occasion)
    belongs_to(:event, Marbles.Event)
    belongs_to(:team, Marbles.Team)
    belongs_to(:marble, Marbles.Marble)

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
