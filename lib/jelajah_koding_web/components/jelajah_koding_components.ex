defmodule JelajahKodingWeb.JelajahKodingComponents do
  use Phoenix.Component

  @variants %{
    default: "border-transparent bg-primary text-primary-foreground hover:bg-primary/80",
    secondary: "border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80",
    destructive:
      "border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80",
    outline: "text-foreground"
  }

  attr :class, :string, default: ""
  attr :variant, :string, default: "default"
  slot :inner_block

  def badge(assigns) do
    default_class =
      "inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2"

    class =
      default_class <>
        " " <>
        Map.get(@variants, String.to_atom(assigns.variant), @variants.default) <>
        " " <>
        assigns.class

    assigns = assign(assigns, :class, class)

    ~H"""
    <div class={@class}>{render_slot(@inner_block)}</div>
    """
  end

  attr :class, :string, default: ""
  slot :inner_block

  def scroll_area(assigns) do
    ~H"""
    <div class={@class}>
      <div class="h-full w-full rounded-[inherit]">
        {render_slot(@inner_block)}
      </div>
      <div class="corner" />
    </div>
    """
  end

  attr :class, :string, default: ""
  slot :inner_block, required: true

  def card(assigns) do
    default_class = "rounded-lg border bg-card text-card-foreground shadow-sm"
    class = default_class <> " " <> assigns.class
    assigns = assign(assigns, :class, class)

    ~H"""
    <div class={@class}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :id, :integer, required: true
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :is_paid, :boolean, required: true
  attr :platform, :string, required: true
  attr :tags, :list, required: true
  attr :url, :string, required: true
  attr :class, :string, default: ""

  def resource_card(assigns) do
    default_class =
      "group relative overflow-hidden transition-all duration-300 hover:shadow-lg animate-fade-in"

    class = default_class <> " " <> assigns.class
    assigns = assign(assigns, :class, class)

    ~H"""
    <.card class={@class}>
      <a
        href={"/resources/#{@id}"}
        class="absolute inset-0 z-10"
        aria-label={"View details for #{@title}"}
      />
      <div class="p-6">
        <div class="mb-4 flex items-center justify-between">
          <.badge variant={if @is_paid, do: "default", else: "secondary"} class="text-xs">
            {if @is_paid, do: "Paid", else: "Free"}
          </.badge>
          <.badge variant="outline" class="text-xs">
            {@platform}
          </.badge>
        </div>
        <h3 class="mb-2 text-xl font-semibold tracking-tight group-hover:text-primary transition-colors">
          {@title}
          <.icon_external_link class="ml-2 inline h-4 w-4 opacity-0 transition-opacity group-hover:opacity-100" />
        </h3>
        <p class="mb-4 text-sm text-muted-foreground line-clamp-2">
          {@description}
        </p>
        <div class="flex flex-wrap gap-2">
          <%= for tag <- @tags do %>
            <.badge variant="outline" class="text-xs">
              {tag}
            </.badge>
          <% end %>
        </div>
      </div>
    </.card>
    """
  end

  attr :class, :string, default: ""
  slot :inner_block

  def icon_external_link(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class={@class}
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    >
      <path d="M18 13V18A2 2 0 0 1 16 20H6A2 2 0 0 1 4 18V8A2 2 0 0 1 6 6H11"></path>
      <polyline points="15 3 21 3 21 9"></polyline>
      <line x1="10" y1="14" x2="21" y2="3"></line>
    </svg>
    """
  end

  def input_jk(assigns) do
    default_class =
      "flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-base ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium file:text-foreground placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 md:text-sm"

    class = default_class <> " " <> assigns.class
    assigns = assign(assigns, :class, class)

    ~H"""
    <input type={@type} class={@class} placeholder={@placeholder} name={@name} value={@value} />
    """
  end

  # Render a single tag.
  # You can customize the default classes as needed.
  attr :tag, :string, required: true
  attr :class, :string, default: "bg-gray-200 text-gray-800"

  def tag(assigns) do
    ~H"""
    <span class={"inline-flex items-center px-2 py-1 rounded-full text-xs font-medium " <> @class}>
      {@tag}
    </span>
    """
  end

  # Render a list of tags.
  attr :tags, :list, required: true
  attr :class, :string, default: ""

  def tag_list(%{tags: tags} = assigns) do
    tag_names = Enum.map(tags, & &1.name)

    ~H"""
    <div class={"flex flex-wrap gap-2 " <> @class}>
      <%= for tag <- tag_names do %>
        <.tag tag={tag} />
      <% end %>
    </div>
    """
  end

  # Tag selector component for handling multiple tags
  attr :field, :any, required: true
  attr :available_tags, :list, default: []
  attr :selected_tags, :list, default: []

  def tag_selector(assigns) do
    ~H"""
    <div class="space-y-4" phx-update="ignore" id="tag-selector">
      <div>
        <label class="block text-sm font-medium text-gray-700">Tags</label>
        <div class="mt-1">
          <select
            id="tag-select"
            class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"
          >
            <option value="">Select a tag...</option>
            <%= for tag <- @available_tags do %>
              <option value={tag.id}><%= tag.name %></option>
            <% end %>
          </select>
        </div>
      </div>

      <div class="selected-tags space-y-2">
        <div class="flex flex-wrap gap-2" id="selected-tags-container">
          <%= for tag <- @selected_tags do %>
            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-sm font-medium bg-indigo-100 text-indigo-800">
              <%= tag.name %>
              <button
                type="button"
                phx-click="remove_tag"
                phx-value-tag-id={tag.id}
                class="ml-1.5 inline-flex items-center justify-center w-4 h-4 text-indigo-400 hover:bg-indigo-200 hover:text-indigo-500 rounded-full focus:outline-none"
              >
                <svg class="h-3 w-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
              <input type="hidden" name={"resource[tag_ids][]"} value={tag.id} />
            </span>
          <% end %>
        </div>
      </div>
    </div>

    <script>
      document.querySelector("#tag-select")?.addEventListener("change", (e) => {
        const tagId = e.target.value;
        if (!tagId) return;

        const tagName = e.target.options[e.target.selectedIndex].text;
        const container = document.querySelector("#selected-tags-container");
        
        // Check if tag is already selected
        if (container.querySelector(`input[value="${tagId}"]`)) {
          e.target.value = "";
          return;
        }

        // Create new tag element
        const tagElement = document.createElement("span");
        tagElement.className = "inline-flex items-center px-2.5 py-0.5 rounded-full text-sm font-medium bg-indigo-100 text-indigo-800";
        tagElement.innerHTML = `
          ${tagName}
          <button
            type="button"
            class="ml-1.5 inline-flex items-center justify-center w-4 h-4 text-indigo-400 hover:bg-indigo-200 hover:text-indigo-500 rounded-full focus:outline-none"
            onclick="this.parentElement.remove()"
          >
            <svg class="h-3 w-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
          <input type="hidden" name="resource[tag_ids][]" value="${tagId}" />
        `;

        container.appendChild(tagElement);
        e.target.value = "";
      });
    </script>
    """
  end

end
