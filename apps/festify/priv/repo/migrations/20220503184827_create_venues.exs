defmodule Festify.Repo.Migrations.CreateVenues do
  use Ecto.Migration

  def change do
    create table(:venues) do
      add :global_id, :binary_id, null: false

      timestamps(updated_at: false)
    end

    create unique_index(:venues, :global_id)
  end
end
