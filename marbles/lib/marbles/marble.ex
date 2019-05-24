defmodule Marbles.Marble do
  use Ecto.Schema
  import Ecto.Changeset

  schema "marbles" do
    field(:name, :string)
    belongs_to(:team, Marbles.Team)

    timestamps()
  end

  @doc false
  def changeset(marble, attrs) do
    marble
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
