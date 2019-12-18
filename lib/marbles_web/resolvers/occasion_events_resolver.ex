defmodule MarblesWeb.OccasionEventsResolver do
  alias Marbles.{Occasion, OccasionEvents}

  def list_occasion_events(%Occasion{} = occasion, args, _info) do
    occasion_events = OccasionEvents.list_occasion_events(occasion, args)
    {:ok, occasion_events}
  end

  def list_occasion_events(_root, _args, _info) do
    occasion_events = OccasionEvents.list_occasion_events()
    {:ok, occasion_events}
  end
end
