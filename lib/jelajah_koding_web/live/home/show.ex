defmodule JelajahKodingWeb.HomeLive.Show do
  use JelajahKodingWeb, :live_view

  # alias JelajahKoding.Payments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    resource = %{
      id: id,
      title: "Jelajah Koding",
      author: "Jelajah Koding",
      platform: "Jelajah Koding",
      description: "Jelajah Koding",
      url: "Jelajah Koding",
      duration: "Jelajah Koding",
      last_updated: "Jelajah Koding"
    }

    {
      :noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:resource, resource)
      #  |> assign(:payment, Payments.get_payment!(id))
    }
  end

  defp page_title(:show), do: "Show Resource"
end
