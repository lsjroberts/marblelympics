defmodule Marbles.Competitors do
  import Ecto.Query, warn: false
  alias Marbles.{Competitor, Marble, Occasion, Repo}

  def list_competitors(%Occasion{} = occasion, %{event: event_id}) do
    from(c in Competitor, where: c.occasion_id == ^occasion.id, where: c.event_id == ^event_id)
    |> Repo.all()
  end

  def list_competitors(%Occasion{} = occasion, _) do
    from(c in Competitor, where: c.occasion_id == ^occasion.id)
    |> Repo.all()
  end

  def list_competitors(%Marble{} = marble, _) do
    from(c in Competitor, where: c.marble_id == ^marble.id)
    |> Repo.all()
  end

  # def list_competitors(%{marble_id: marble_id}) do
  #   from(c in Competitor, where: c.marble_id == ^marble_id)
  #   |> Repo.all()
  # end

  def list_competitors do
    Repo.all(Competitor)
  end
end
