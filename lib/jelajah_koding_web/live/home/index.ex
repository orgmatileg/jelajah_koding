defmodule JelajahKodingWeb.HomeLive.Index do
  use JelajahKodingWeb, :live_view

  alias JelajahKoding.Tags
  alias JelajahKoding.Resources

  def mount(_params, _session, socket) do
    tags = Tags.list_tags()
    resources = Resources.list_resources()

    socket = socket |> stream(:tags, tags) |> stream(:resources, resources)
    {:ok, socket}
  end
end
