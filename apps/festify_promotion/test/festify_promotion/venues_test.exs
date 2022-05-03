defmodule FestifyPromotion.VenuesTest do
  use FestifyPromotion.DataCase

  alias FestifyPromotion.Venues

  test "venues initially empty" do
    venues = Venues.list_venues()
    assert Enum.empty?(venues)
  end
end
