defmodule FestifyPromotion.VenuesTest do
  use FestifyPromotion.DataCase

  alias FestifyPromotion.Venues

  test "venues initially empty" do
    venues = Venues.list_venues()
    assert Enum.empty?(venues)
  end

  describe "adding venue" do
    test "venue is returned" do
      global_id = Ecto.UUID.generate()

      venue_info =
        Venues.Controls.VenueInfo.example(global_id: global_id, name: "American Airlines Center")

      Venues.save_venue(venue_info)

      venues = Venues.list_venues()
      assert Enum.any?(venues, &(&1.global_id == global_id))
    end
  end

  describe "adding venue twice" do
    test "one venue is added" do
      global_id = Ecto.UUID.generate()

      venue_info =
        Venues.Controls.VenueInfo.example(global_id: global_id, name: "American Airlines Center")

      Venues.save_venue(venue_info)
      Venues.save_venue(venue_info)

      venues = Venues.list_venues()
      assert Enum.count(venues) == 1
    end
  end
end
