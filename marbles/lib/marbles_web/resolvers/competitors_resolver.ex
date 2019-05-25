defmodule MarblesWeb.CompetitorsResolver do
  alias Marbles.{Competitors, Marble, Occasion}

  def list_competitors(%Occasion{} = occasion, args, _info) do
    competitors = Competitors.list_competitors(occasion, args)
    {:ok, competitors}
  end

  def list_competitors(%Marble{} = marble, args, _info) do
    competitors = Competitors.list_competitors(marble, args)
    {:ok, competitors}
  end

  def list_competitors(root, args, _info) do
    competitors = Competitors.list_competitors(root, args)
    {:ok, competitors}
  end

  def list_competitors(_root, _args, _info) do
    competitors = Competitors.list_competitors()
    {:ok, competitors}
  end
end
