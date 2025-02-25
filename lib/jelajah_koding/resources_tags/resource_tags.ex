defmodule JelajahKoding.ResourcesTags.ResourceTags do
  use Ecto.Schema
  import Ecto.Changeset
  alias JelajahKoding.Resources.Resource
  alias JelajahKoding.Tags.Tag

  @primary_key false
  schema "resources_tags" do
    belongs_to :resource, Resource, foreign_key: :resource_id, references: :id
    belongs_to :tag, Tag, foreign_key: :tag_id, references: :id

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(resource_tag, attrs) do
    resource_tag
    |> cast(attrs, [:resource_id, :tag_id])
    |> validate_required([:resource_id, :tag_id])
    |> unique_constraint([:resource_id, :tag_id])
  end
end
