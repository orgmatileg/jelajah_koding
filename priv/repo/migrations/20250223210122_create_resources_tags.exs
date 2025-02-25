defmodule JelajahKoding.Repo.Migrations.CreateResourcesTags do
  use Ecto.Migration

  def change do
    create table(:resources_tags, primary_key: false) do
      add :resource_id, references(:resources)
      add :tag_id, references(:tags)
      timestamps(updated_at: false)
    end

    create unique_index(:resources_tags, [:resource_id, :tag_id])
  end
end
