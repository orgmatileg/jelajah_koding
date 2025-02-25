defmodule JelajahKodingWeb.CreatorHTML do
  use JelajahKodingWeb, :html

  embed_templates "creator_html/*"

  @doc """
  Renders a tag form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def creator_form(assigns)
end
