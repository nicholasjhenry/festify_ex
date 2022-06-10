defmodule FestifyPromotion.Venues do
  import Ecto.Query, warn: false

  alias Festify.Repo
  alias FestifyPromotion.Venues.Venue
  alias FestifyPromotion.Venues.VenueDescription
  alias FestifyPromotion.Venues.VenueInfo

  def get_venue(global_id) do
    Venue
    |> not_removed
    |> Repo.get_by(global_id: global_id)
    |> Repo.preload([:descriptions])
    |> to_venue_info
  end

  defp to_venue_info(nil), do: nil

  defp to_venue_info(venue) do
    last_venue_description = find_last_venue_description(venue)

    last_modified_ticks = get_ticks(last_venue_description.inserted_at)

    %VenueInfo{
      global_id: venue.global_id,
      name: last_venue_description.name,
      city: last_venue_description.city,
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

  def delete_venue(global_id) do
    venue = Repo.get_by(Venue, global_id: global_id)

    venue
    |> Ecto.build_assoc(:removed, removed_at: DateTime.utc_now())
    |> IO.inspect()
    |> Repo.insert(on_conflict: :nothing, conflict_target: :venue_id)
  end

  defp maybe_insert_venue_description(venue_info, repo, %{venue: venue}) do
    last_venue_description =
      venue
      |> Repo.preload([:descriptions])
      |> find_last_venue_description()

    modified_ticks = get_ticks(last_venue_description.inserted_at)

    venue_description = %VenueDescription{
      venue_id: venue.id,
      name: venue_info.name,
      city: venue_info.city
    }

    if venue_info.last_modified_ticks != {0, 0} &&
         modified_ticks != venue_info.last_modified_ticks do
      raise Ecto.StaleEntryError, action: :insert, changeset: %{data: venue_description}
    end

    if last_venue_description.name != venue_info.name ||
         last_venue_description.city != venue_info.city do
      repo.insert(venue_description)
    else
      {:ok, last_venue_description}
    end
  end

  defp find_last_venue_description(venue) do
    venue.descriptions
    |> Enum.sort(&(NaiveDateTime.compare(&1.inserted_at, &2.inserted_at) != :lt))
    |> List.first(%VenueDescription{})
  end

  defp not_removed(query) do
    from venue in query, left_join: removed in assoc(venue, :removed), where: is_nil(removed.id)
  end

  defp get_ticks(date_time) do
    if date_time do
      DateTime.to_gregorian_seconds(date_time)
    else
      {0, 0}
    end
  end
end
