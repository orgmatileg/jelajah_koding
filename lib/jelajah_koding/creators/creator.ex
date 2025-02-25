defmodule JelajahKoding.Creators.Creator do
  use Ecto.Schema
  import Ecto.Changeset

  schema "creators" do
    field :name, :string
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(creator, attrs) do
    creator
    |> cast(attrs, [:name, :url])
    |> validate_required([:name, :url])
  end
end
