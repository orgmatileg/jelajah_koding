defmodule JelajahKodingWeb.HomeLive.Index do
  use JelajahKodingWeb, :live_view

  alias JelajahKoding.Tags
  alias JelajahKoding.Resources
  alias JelajahKodingWeb.Presence

  def mount(_params, _session, socket) do
    tags = Tags.list_tags()
    resources = Resources.list_resources()
    selected_filter_is_free = "all"
    selected_filter_tag = "all"
    search_query = ""

    socket =
      socket
      |> assign(:selected_filter_is_free, selected_filter_is_free)
      |> assign(:selected_filter_tag, selected_filter_tag)
      |> assign(:tags, tags)
      |> assign(:resources, resources)
      |> assign(:search_query, search_query)
      # initialize count
      |> assign(:user_count, 0)

    if connected?(socket) do
      # Subscribe to a topic for presence updates
      JelajahKodingWeb.Endpoint.subscribe("presence:home")
      # Track the current socket (using socket.id as a unique key)
      Presence.track(self(), "presence:home", socket.id, %{})
      # Set the initial count from the current presences
      user_count = Presence.list("presence:home") |> map_size()
      socket = assign(socket, :user_count, user_count)
      {:ok, socket}
    else
      {:ok, socket}
    end
  end

  # Update the count whenever the presence diff is broadcast
  def handle_info(%{event: "presence_diff"}, socket) do
    user_count = Presence.list("presence:home") |> map_size()
    {:noreply, assign(socket, :user_count, user_count)}
  end

  def handle_event("filter_is_free", %{"filter" => filter}, socket) do
    resources =
      case filter do
        "all" -> Resources.list_resources()
        "free" -> Resources.list_resources(%{"is_free" => true})
        "paid" -> Resources.list_resources(%{"is_free" => false})
      end

    socket =
      socket
      |> assign(:selected_filter_is_free, filter)
      |> assign(:selected_filter_tag, "all")
      |> assign(:resources, resources)

    {:noreply, socket}
  end

  def handle_event("filter_tag", %{"filter" => tag}, socket) do
    resources =
      case tag do
        "all" -> Resources.list_resources()
        _ -> Resources.list_resources(%{"tag" => tag})
      end

    socket =
      socket
      |> assign(:selected_filter_tag, tag)
      |> assign(:selected_filter_is_free, "all")
      |> assign(:resources, resources)

    {:noreply, socket}
  end

  def handle_event("search", %{"search" => search}, socket) do
    resources =
      Resources.list_resources(%{"title" => search})

    socket =
      socket
      |> assign(:resources, resources)
      |> assign(:search_query, search)
      |> assign(:selected_filter_is_free, "all")
      |> assign(:selected_filter_tag, "all")

    {:noreply, socket}
  end

  def handle_event("noop", _, socket), do: {:noreply, socket}
end
