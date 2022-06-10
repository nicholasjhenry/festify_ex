defmodule FestifyPromotion.Venues.VenueRemoved do
  @moduledoc false

  use Festify.Schema

  alias FestifyPromotion.Venues.Venue

  schema "venue_removals" do
    field :removed_at, :utc_datetime_usec

    belongs_to :venue, Venue

    timestamps(updated_at: false)
  end
end
