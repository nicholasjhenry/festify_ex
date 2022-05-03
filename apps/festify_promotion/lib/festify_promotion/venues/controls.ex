defmodule FestifyPromotion.Venues.Controls do
  alias FestifyPromotion.Controls
  alias FestifyPromotion.Venues

  defmodule VenueInfo do
    def example(attrs) do
      defaults = %{
        global_id: Ecto.UUID.generate(),
        name: "Jane Smith",
        city: "Auckland",
        last_modified: Controls.Time.example()
      }

      attrs = Enum.into(attrs, defaults)
      struct!(Venues.VenueInfo, attrs)
    end
  end
end
