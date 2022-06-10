defmodule FestifyPromotion.Venues.VenueDescription do
  @moduledoc false

  use Festify.Schema

  alias FestifyPromotion.Venues.Venue

  schema "venue_descriptions" do
    field :name, :string
    field :city, :string

    belongs_to :venue, Venue

    timestamps(updated_at: false)
  end
end
