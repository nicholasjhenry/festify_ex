defmodule FestifyPromotion.Venues.Venue do
  @moduledoc false

  use Festify.Schema

  alias FestifyPromotion.Venues.VenueDescription
  alias FestifyPromotion.Venues.VenueRemoved

  schema "venues" do
    field :global_id, :binary_id
    has_many :descriptions, VenueDescription
    has_one :removed, VenueRemoved

    timestamps(updated_at: false)
  end
end
