defmodule MarblesWeb.TeamsResolver do
  alias Marbles.{Competitor, Marble, Occasion, Teams}

  def list_teams(%Occasion{} = occasion, args, _info) do
    teams = Teams.list_teams(occasion, args)
    {:ok, teams}
  end

  def list_teams(%Marble{} = marble, args, _info) do
    teams = Teams.list_teams(marble, args)
    {:ok, teams}
  end

  def list_teams(_root, _args, _info) do
    teams = Teams.list_teams()
    {:ok, teams}
  end

  def get_team(%Competitor{} = competitor, _args, _info) do
    case Teams.get_team!(competitor.team_id) do
      nil ->
        {:error, "Team ID #{competitor.team_id} not found"}

      team ->
        {:ok, team}
    end
  end

  def get_team(%Marble{} = marble, _args, _info) do
    case Teams.get_team!(marble.team_id) do
      nil ->
        {:error, "Team ID #{marble.team_id} not found"}

      team ->
        {:ok, team}
    end
  end

  def get_team(_root, %{id: id}, _info) do
    case Teams.get_team!(id) do
      nil ->
        {:error, "Team ID #{id} not found"}

      team ->
        {:ok, team}
    end
  end
end
