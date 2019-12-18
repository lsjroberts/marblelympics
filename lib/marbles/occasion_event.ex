defmodule Marbles.OccasionEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "occasion_events" do
    field(:date, :date)
    belongs_to(:occasion, Marbles.Occasion)
    belongs_to(:event, Marbles.Event)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
