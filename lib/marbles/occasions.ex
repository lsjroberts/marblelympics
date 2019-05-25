defmodule Marbles.Occasions do
  import Ecto.Query, warn: false
  alias Marbles.Repo

  alias Marbles.Occasion

  def list_occasions(event, _) do
    from(o in Occasion, join: e in assoc(o, :events), where: e.id == ^event.id)
    |> Repo.all()
  end

  def list_occasions do
    Repo.all(Occasion)
  end

  def get_occasion!(id), do: Repo.get!(Occasion, id)
end
