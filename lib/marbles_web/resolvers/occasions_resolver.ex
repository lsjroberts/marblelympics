defmodule MarblesWeb.OccasionsResolver do
  alias Marbles.{Competitor, Event, Occasions}

  def list_occasions(%Event{} = event, args, _info) do
    occasions = Occasions.list_occasions(event, args)
    {:ok, occasions}
  end

  def list_occasions(_root, _args, _info) do
    occasions = Occasions.list_occasions()
    {:ok, occasions}
  end

  def get_occasion(%Competitor{} = competitor, _args, _info) do
    case Occasions.get_occasion!(competitor.occasion_id) do
      nil ->
        {:error, "Occasion ID #{competitor.occasion_id} not found"}

      occasion ->
        {:ok, occasion}
    end
  end

  def get_occasion(_root, %{id: id}, _info) do
    case Occasions.get_occasion!(id) do
      nil ->
        {:error, "Occasion ID #{id} not found"}

      occasion ->
        {:ok, occasion}
    end
  end
end
