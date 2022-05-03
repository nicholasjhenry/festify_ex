defmodule FestifyPromotion.Venues do
  import Ecto.Query, warn: false

  alias Festify.Repo
  alias FestifyPromotion.Venues.Venue
  alias FestifyPromotion.Venues.VenueInfo

  def list_venues do
    Venue
    |> Repo.all()
    |> Enum.map(&%VenueInfo{global_id: &1.global_id})
  end

  def save_venue(venue_info) do
    Repo.insert!(%Venue{global_id: venue_info.global_id},
      on_conflict: :nothing,
      target: :global_id
    )
  end
end
