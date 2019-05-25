defmodule Marbles.Marbles do
  import Ecto.Query, warn: false
  alias Marbles.Repo

  alias Marbles.Marble

  def list_marbles(team, _) do
    from(m in Marble, where: m.team_id == ^team.id)
    |> Repo.all()
  end

  def list_marbles(%{team: team_id}) do
    from(m in Marble, where: m.team_id == ^team_id)
    |> Repo.all()
  end

  def list_marbles do
    Repo.all(Marble)
  end

  def get_marble!(id), do: Repo.get!(Marble, id)
end
