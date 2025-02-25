defmodule JelajahKodingWeb.ResourceHTML do
  use JelajahKodingWeb, :html

  embed_templates "resource_html/*"

  @doc """
  Renders a resource form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :available_tags, :list, default: []
  attr :selected_tags, :list, default: []
  attr :available_creators, :list, default: []

  def resource_form(assigns)
end
