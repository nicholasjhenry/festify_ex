defmodule Festify.Repo.Migrations.CreateVenueRemovals do
  use Ecto.Migration

  def change do
    create table(:venue_removals) do
      add :venue_id, references(:venues, on_delete: :delete_all), null: false
      add :removed_at, :utc_datetime_usec, null: false

      timestamps(updated_at: false)
    end

    create unique_index(:venue_removals, :venue_id)
  end
end
