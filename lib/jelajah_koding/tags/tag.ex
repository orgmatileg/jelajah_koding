defmodule JelajahKoding.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias JelajahKoding.Resources.Resource
  alias JelajahKoding.ResourcesTags.ResourceTags

  schema "tags" do
    field :name, :string

    many_to_many :resources, Resource,
      join_through: ResourceTags,
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
