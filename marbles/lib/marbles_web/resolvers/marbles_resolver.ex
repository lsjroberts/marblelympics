defmodule MarblesWeb.MarblesResolver do
  alias Marbles.{Competitor, Marbles, Team}

  def list_marbles(%Team{} = team, args, _info) do
    marbles = Marbles.list_marbles(team, args)
    {:ok, marbles}
  end

  def list_marbles(_root, _args, _info) do
    marbles = Marbles.list_marbles()
    {:ok, marbles}
  end

  def get_marble(%Competitor{} = competitor, _args, _info) do
    case Marbles.get_marble!(competitor.marble_id) do
      nil ->
        {:error, "Marble ID #{competitor.marble_id} not found"}

      marble ->
        {:ok, marble}
    end
  end

  def get_marble(_root, %{id: id}, _info) do
    case Marbles.get_marble!(id) do
      nil ->
        {:error, "Marble ID #{id} not found"}

      marble ->
        {:ok, marble}
    end
  end
end
