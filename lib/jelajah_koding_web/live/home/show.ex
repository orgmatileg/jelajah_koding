defmodule JelajahKodingWeb.HomeLive.Show do
  use JelajahKodingWeb, :live_view

  alias JelajahKoding.Resources

  # alias JelajahKoding.Payments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    resource = Resources.get_resource_with_creator_and_tags!(id)

    {
      :noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:resource, resource)
    }
  end

  defp page_title(:show), do: "Show Resource"
end
