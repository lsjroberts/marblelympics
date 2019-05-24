defmodule Marbles.Occasion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "occasions" do
    field(:name, :string)
    many_to_many(:events, Marbles.Event, join_through: "occasion_events")

    timestamps()
  end

  @doc false
  def changeset(occasion, attrs) do
    occasion
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
