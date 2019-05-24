defmodule Marbles.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field(:name, :string)
    many_to_many(:occasions, Marbles.Occasion, join_through: "occasion_events")

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
