defmodule FestifyPromotion.Venues do
  import Ecto.Query, warn: false

  alias Festify.Repo
  alias FestifyPromotion.Venues.Venue
  alias FestifyPromotion.Venues.VenueDescription
  alias FestifyPromotion.Venues.VenueInfo

  def get_venue(global_id) do
    Venue
    |> Repo.get_by!(global_id: global_id)
    |> Repo.preload([:descriptions])
    |> to_venue_info
  end

  defp to_venue_info(venue) do
    last_venue_description = find_last_venue_description(venue)

    last_modified_ticks =
      if last_venue_description.inserted_at do
        DateTime.to_gregorian_seconds(last_venue_description.inserted_at)
      else
        {0, 0}
      end

    %VenueInfo{
      global_id: venue.global_id,
      name: last_venue_description.name,
      last_modified_ticks: last_modified_ticks
    }
  end

  def list_venues do
    Venue
    |> Repo.all()
    |> Repo.preload([:descriptions])
    |> Enum.map(&to_venue_info/1)
  end

  def save_venue(venue_info) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:venue, %Venue{global_id: venue_info.global_id},
      # `on_conflict` update (set) option required to return primary key
      # https://hexdocs.pm/ecto/constraints-and-upserts.html#upserts
      #
      on_conflict: [set: [global_id: venue_info.global_id]],
      conflict_target: :global_id
    )
    |> Ecto.Multi.run(:description, &maybe_insert_venue_description(venue_info, &1, &2))
    |> Repo.transaction()
  end

  defp maybe_insert_venue_description(venue_info, repo, %{venue: venue}) do
    last_venue_description =
      venue
      |> Repo.preload([:descriptions])
      |> find_last_venue_description()

    if last_venue_description.name != venue_info.name &&
         last_venue_description.city != venue_info.city do
      %VenueDescription{
        venue_id: venue.id,
        name: venue_info.name,
        city: venue_info.city
      }
      |> repo.insert()
    else
      {:ok, last_venue_description}
    end
  end

  defp find_last_venue_description(venue) do
    venue.descriptions
    |> Enum.sort(&(NaiveDateTime.compare(&1.inserted_at, &2.inserted_at) != :lt))
    |> List.first(%VenueDescription{})
  end
end
