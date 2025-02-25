defmodule JelajahKoding.Repo.Migrations.CreateCreators do
  use Ecto.Migration

  def change do
    create table(:creators) do
      add :name, :string
      add :url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
