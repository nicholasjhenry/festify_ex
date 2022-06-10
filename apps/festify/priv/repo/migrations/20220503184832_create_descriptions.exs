defmodule Festify.Repo.Migrations.CreateDescriptions do
  use Ecto.Migration

  def change do
    create table(:venue_descriptions) do
      add :venue_id, references(:venues, on_delete: :delete_all), null: false
      add :name, :string, null: false
      add :city, :string, null: false

      timestamps(updated_at: false)
    end

    create index(:venue_descriptions, :venue_id)
  end
end
