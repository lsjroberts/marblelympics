defmodule Marbles.Events do
  import Ecto.Query, warn: false
  alias Marbles.Repo

  alias Marbles.Event

  def list_events(occasion, _) do
    from(e in Event, join: o in assoc(e, :occasions)) |> Repo.all()
  end

  def list_events do
    Repo.all(Event)
  end

  def get_event!(id), do: Repo.get!(Event, id)
end
