defmodule Marbles.OccasionEvents do
  import Ecto.Query, warn: false
  alias Marbles.{Occasion, OccasionEvent, Repo}

  def list_occasion_events(%Occasion{} = occasion, _) do
    from(c in OccasionEvent, where: c.occasion_id == ^occasion.id)
    |> Repo.all()
  end

  def list_occasion_events do
    Repo.all(OccasionEvent)
  end
end
