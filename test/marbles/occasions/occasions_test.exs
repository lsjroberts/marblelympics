defmodule Marbles.OccasionsTest do
  use Marbles.DataCase

  alias Marbles.Occasions

  describe "events" do
    alias Marbles.Occasions.Event

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Occasions.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Occasions.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Occasions.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Occasions.create_event(@valid_attrs)
      assert event.name == "some name"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Occasions.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Occasions.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.name == "some updated name"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Occasions.update_event(event, @invalid_attrs)
      assert event == Occasions.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Occasions.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Occasions.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Occasions.change_event(event)
    end
  end

  describe "occasions" do
    alias Marbles.Occasions.Occasion

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def occasion_fixture(attrs \\ %{}) do
      {:ok, occasion} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Occasions.create_occasion()

      occasion
    end

    test "list_occasions/0 returns all occasions" do
      occasion = occasion_fixture()
      assert Occasions.list_occasions() == [occasion]
    end

    test "get_occasion!/1 returns the occasion with given id" do
      occasion = occasion_fixture()
      assert Occasions.get_occasion!(occasion.id) == occasion
    end

    test "create_occasion/1 with valid data creates a occasion" do
      assert {:ok, %Occasion{} = occasion} = Occasions.create_occasion(@valid_attrs)
      assert occasion.name == "some name"
    end

    test "create_occasion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Occasions.create_occasion(@invalid_attrs)
    end

    test "update_occasion/2 with valid data updates the occasion" do
      occasion = occasion_fixture()
      assert {:ok, occasion} = Occasions.update_occasion(occasion, @update_attrs)
      assert %Occasion{} = occasion
      assert occasion.name == "some updated name"
    end

    test "update_occasion/2 with invalid data returns error changeset" do
      occasion = occasion_fixture()
      assert {:error, %Ecto.Changeset{}} = Occasions.update_occasion(occasion, @invalid_attrs)
      assert occasion == Occasions.get_occasion!(occasion.id)
    end

    test "delete_occasion/1 deletes the occasion" do
      occasion = occasion_fixture()
      assert {:ok, %Occasion{}} = Occasions.delete_occasion(occasion)
      assert_raise Ecto.NoResultsError, fn -> Occasions.get_occasion!(occasion.id) end
    end

    test "change_occasion/1 returns a occasion changeset" do
      occasion = occasion_fixture()
      assert %Ecto.Changeset{} = Occasions.change_occasion(occasion)
    end
  end
end
