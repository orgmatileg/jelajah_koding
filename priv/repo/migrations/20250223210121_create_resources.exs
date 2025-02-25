defmodule JelajahKoding.Repo.Migrations.CreateResources do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :title, :string, required: true
      add :description, :string, required: true
      add :platform, :string, required: true
      add :is_free, :boolean, default: false, required: true
      add :url, :string, required: true
      add :creator_id, references(:creators, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:resources, [:creator_id])
  end
end
