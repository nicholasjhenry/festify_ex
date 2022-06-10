defmodule FestifyPromotion.VenuesTest do
  use FestifyPromotion.DataCase

  alias FestifyPromotion.Venues
  alias FestifyPromotion.Controls

  test "venues initially empty" do
    venues = Venues.list_venues()
    assert Enum.empty?(venues)
  end

  describe "when adding venue" do
    test "venue is returned" do
      global_id = Controls.Id.example()

      Venues.Controls.VenueInfo.New.example(
        global_id: global_id,
        name: "American Airlines Center"
      )
      |> Venues.save_venue()

      venues = Venues.list_venues()
      assert Enum.any?(venues, &(&1.global_id == global_id))
    end
  end

  describe "when adding venue twice" do
    test "one venue is added" do
      global_id = Controls.Id.example()

      Venues.Controls.VenueInfo.New.example(
        global_id: global_id,
        name: "American Airlines Center"
      )
      |> Venues.save_venue()

      Venues.Controls.VenueInfo.New.example(
        global_id: global_id,
        name: "American Airlines Center"
      )
      |> Venues.save_venue()

      venues = Venues.list_venues()
      assert Enum.count(venues) == 1
    end
  end

  describe "when setting venue description " do
    test "venue description is returned" do
      global_id = Controls.Id.example()

      Venues.Controls.VenueInfo.New.example(
        global_id: global_id,
        name: "American Airlines Center"
      )
      |> Venues.save_venue()

      venue = Venues.get_venue(global_id)

      assert venue.name == "American Airlines Center"
    end
  end

  describe "setting venue to same description" do
    test "nothing is saved" do
      global_id = Controls.Id.example()

      Venues.Controls.VenueInfo.New.example(
        global_id: global_id,
        name: "American Airlines Center"
      )
      |> Venues.save_venue()

      first_snapshot = Venues.get_venue(global_id)

      Venues.Controls.VenueInfo.New.example(
        global_id: global_id,
        name: "American Airlines Center"
      )
      |> Venues.save_venue()

      second_snapshot = Venues.get_venue(global_id)

      assert first_snapshot.last_modified_ticks == second_snapshot.last_modified_ticks
    end
  end

  describe "when venue is modified concurrently" do
    test "exception is thrown" do
      global_id = Controls.Id.example()

      Venues.Controls.VenueInfo.New.example(global_id: global_id)
      |> Venues.save_venue()

      venue = Venues.get_venue(global_id)

      %{venue | name: "Change 1"} |> Venues.save_venue()

      assert_raise Ecto.StaleEntryError, fn ->
        %{venue | name: "Change 2"} |> Venues.save_venue()
      end
    end
  end

  describe "when deleting venue" do
    test "venue is not returned" do
      global_id = Controls.Id.example()

      Venues.Controls.VenueInfo.New.example(global_id: global_id)
      |> Venues.save_venue()

      Venues.delete_venue(global_id)

      refute Venues.get_venue(global_id)
    end
  end
end
