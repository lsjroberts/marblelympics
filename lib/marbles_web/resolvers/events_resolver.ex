defmodule MarblesWeb.EventsResolver do
  alias Marbles.{Competitor, Events, Occasion}

  def list_events(%Occasion{} = occasion, args, _info) do
    events = Events.list_events(occasion, args)
    {:ok, events}
  end

  def list_events(_root, _args, _info) do
    events = Events.list_events()
    {:ok, events}
  end

  def get_event(%Competitor{} = competitor, _args, _info) do
    case Events.get_event!(competitor.event_id) do
      nil ->
        {:error, "Event ID #{competitor.event_id} not found"}

      event ->
        {:ok, event}
    end
  end
end
