defmodule Marbles.MarblesTest do
  use Marbles.DataCase

  alias Marbles.Marbles

  describe "marbles" do
    alias Marbles.Marbles.Marble

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def marble_fixture(attrs \\ %{}) do
      {:ok, marble} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marbles.create_marble()

      marble
    end

    test "list_marbles/0 returns all marbles" do
      marble = marble_fixture()
      assert Marbles.list_marbles() == [marble]
    end

    test "get_marble!/1 returns the marble with given id" do
      marble = marble_fixture()
      assert Marbles.get_marble!(marble.id) == marble
    end

    test "create_marble/1 with valid data creates a marble" do
      assert {:ok, %Marble{} = marble} = Marbles.create_marble(@valid_attrs)
      assert marble.name == "some name"
    end

    test "create_marble/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marbles.create_marble(@invalid_attrs)
    end

    test "update_marble/2 with valid data updates the marble" do
      marble = marble_fixture()
      assert {:ok, marble} = Marbles.update_marble(marble, @update_attrs)
      assert %Marble{} = marble
      assert marble.name == "some updated name"
    end

    test "update_marble/2 with invalid data returns error changeset" do
      marble = marble_fixture()
      assert {:error, %Ecto.Changeset{}} = Marbles.update_marble(marble, @invalid_attrs)
      assert marble == Marbles.get_marble!(marble.id)
    end

    test "delete_marble/1 deletes the marble" do
      marble = marble_fixture()
      assert {:ok, %Marble{}} = Marbles.delete_marble(marble)
      assert_raise Ecto.NoResultsError, fn -> Marbles.get_marble!(marble.id) end
    end

    test "change_marble/1 returns a marble changeset" do
      marble = marble_fixture()
      assert %Ecto.Changeset{} = Marbles.change_marble(marble)
    end
  end
end
