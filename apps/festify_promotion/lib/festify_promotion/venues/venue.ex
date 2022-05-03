defmodule FestifyPromotion.Venues.Venue do
  @moduledoc false

  use Festify.Schema

  schema "venues" do
    field :global_id, :binary_id

    timestamps(updated_at: false)
  end
end
