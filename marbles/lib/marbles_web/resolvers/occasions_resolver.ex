defmodule MarblesWeb.OccasionsResolver do
  alias Marbles.Occasions

  def list_occasions(_root, _args, _info) do
    occasions = Occasions.list_occasions()
    {:ok, occasions}
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
