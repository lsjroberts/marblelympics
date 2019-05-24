defmodule Marbles.Marbles do
  @moduledoc """
  The Marbles context.
  """

  import Ecto.Query, warn: false
  alias Marbles.Repo

  alias Marbles.Marble

  @doc """
  Returns the list of marbles.

  ## Examples

      iex> list_marbles()
      [%Marble{}, ...]

  """
  def list_marbles do
    Repo.all(Marble)
  end

  @doc """
  Gets a single marble.

  Raises `Ecto.NoResultsError` if the Marble does not exist.

  ## Examples

      iex> get_marble!(123)
      %Marble{}

      iex> get_marble!(456)
      ** (Ecto.NoResultsError)

  """
  def get_marble!(id), do: Repo.get!(Marble, id)

  @doc """
  Creates a marble.

  ## Examples

      iex> create_marble(%{field: value})
      {:ok, %Marble{}}

      iex> create_marble(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_marble(attrs \\ %{}) do
    %Marble{}
    |> Marble.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a marble.

  ## Examples

      iex> update_marble(marble, %{field: new_value})
      {:ok, %Marble{}}

      iex> update_marble(marble, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_marble(%Marble{} = marble, attrs) do
    marble
    |> Marble.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Marble.

  ## Examples

      iex> delete_marble(marble)
      {:ok, %Marble{}}

      iex> delete_marble(marble)
      {:error, %Ecto.Changeset{}}

  """
  def delete_marble(%Marble{} = marble) do
    Repo.delete(marble)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking marble changes.

  ## Examples

      iex> change_marble(marble)
      %Ecto.Changeset{source: %Marble{}}

  """
  def change_marble(%Marble{} = marble) do
    Marble.changeset(marble, %{})
  end
end
