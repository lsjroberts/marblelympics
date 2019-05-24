defmodule MarblesWeb.EventsResolver do
  alias Marbles.Events
  alias Marbles.Occasion

  def list_events(%Occasion{} = occasion, args, _info) do
    events = Events.list_events(occasion, args)
    {:ok, events}
  end

  def list_events(_root, _args, _info) do
    events = Events.list_events()
    {:ok, events}
  end
end
