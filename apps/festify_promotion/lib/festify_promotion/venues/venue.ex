defmodule FestifyPromotion.Venues.Venue do
  @moduledoc false

  use Festify.Schema

  alias FestifyPromotion.Venues.Venue
  alias FestifyPromotion.Venues.VenueDescription

  schema "venues" do
    field :global_id, :binary_id
    has_many :descriptions, VenueDescription

    timestamps(updated_at: false)
  end
end
