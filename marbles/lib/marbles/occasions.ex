defmodule Marbles.Occasions do
  @moduledoc """
  The Occasions context.
  """

  import Ecto.Query, warn: false
  alias Marbles.Repo

  alias Marbles.Occasion

  @doc """
  Returns the list of occasions.

  ## Examples

      iex> list_occasions()
      [%Occasion{}, ...]

  """
  def list_occasions do
    Repo.all(Occasion)
  end

  @doc """
  Gets a single occasion.

  Raises `Ecto.NoResultsError` if the Occasion does not exist.

  ## Examples

      iex> get_occasion!(123)
      %Occasion{}

      iex> get_occasion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_occasion!(id), do: Repo.get!(Occasion, id)

  @doc """
  Creates a occasion.

  ## Examples

      iex> create_occasion(%{field: value})
      {:ok, %Occasion{}}

      iex> create_occasion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_occasion(attrs \\ %{}) do
    %Occasion{}
    |> Occasion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a occasion.

  ## Examples

      iex> update_occasion(occasion, %{field: new_value})
      {:ok, %Occasion{}}

      iex> update_occasion(occasion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_occasion(%Occasion{} = occasion, attrs) do
    occasion
    |> Occasion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Occasion.

  ## Examples

      iex> delete_occasion(occasion)
      {:ok, %Occasion{}}

      iex> delete_occasion(occasion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_occasion(%Occasion{} = occasion) do
    Repo.delete(occasion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking occasion changes.

  ## Examples

      iex> change_occasion(occasion)
      %Ecto.Changeset{source: %Occasion{}}

  """
  def change_occasion(%Occasion{} = occasion) do
    Occasion.changeset(occasion, %{})
  end
end
