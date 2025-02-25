defmodule JelajahKoding.Resources.Resource do
  use Ecto.Schema
  import Ecto.Changeset
  alias JelajahKoding.Creators.Creator
  alias JelajahKoding.Tags.Tag
  alias JelajahKoding.ResourcesTags.ResourceTags

  schema "resources" do
    field :title, :string
    field :description, :string
    field :platform, :string
    field :url, :string
    field :is_free, :boolean, default: false

    belongs_to :creator, Creator, foreign_key: :creator_id, references: :id

    many_to_many :tags, Tag,
      join_through: ResourceTags,
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(resource, attrs) do
    resource
    |> cast(attrs, [:title, :description, :platform, :url, :is_free, :creator_id])
    |> validate_required([:title, :description, :platform, :url, :is_free, :creator_id])
    |> put_assoc(:tags, Map.get(attrs, "tags", []))
  end
end
