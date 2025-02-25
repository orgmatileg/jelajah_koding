defmodule JelajahKodingWeb.TagsHTML do
  use JelajahKodingWeb, :html

  embed_templates "tags_html/*"

  @doc """
  Renders a tag form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def tag_form(assigns)
end
