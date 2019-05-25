defmodule Marbles.Teams do
  import Ecto.Query, warn: false
  alias Marbles.Repo

  alias Marbles.Marble
  alias Marbles.Occasion
  alias Marbles.Team

  def list_teams(%Occasion{} = occasion, _) do
    from(t in Team, join: o in assoc(t, :occasions), where: o.id == ^occasion.id)
    |> Repo.all()
  end

  def list_teams(%Marble{} = marble, _) do
    from(t in Team, join: m in assoc(t, :marbles), where: m.id == ^marble.id)
    |> Repo.all()
  end

  def list_teams do
    Repo.all(Team)
  end

  def get_team!(id), do: Repo.get!(Team, id)
end
