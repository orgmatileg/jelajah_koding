defmodule JelajahKodingWeb.ResourceController do
  use JelajahKodingWeb, :controller

  alias JelajahKoding.Resources
  alias JelajahKoding.Resources.Resource
  alias JelajahKoding.Tags
  alias JelajahKoding.Creators

  def index(conn, _params) do
    resources = Resources.list_resources()
    render(conn, :index, resources: resources)
  end

  def new(conn, _params) do
    changeset = Resources.change_resource(%Resource{})
    available_tags = Tags.list_tags()
    available_creators = Creators.list_creators()

    render(conn, :new,
      changeset: changeset,
      available_tags: available_tags,
      selected_tags: [],
      available_creators: available_creators
    )
  end

  def create(conn, %{"resource" => resource_params}) do
    case Resources.create_resource(resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource created successfully.")
        |> redirect(to: ~p"/admins/resources/#{resource}")

      {:error, %Ecto.Changeset{} = changeset} ->
        available_tags = Tags.list_tags()
        available_creators = Creators.list_creators()

        render(conn, :new,
          changeset: changeset,
          available_tags: available_tags,
          selected_tags: [],
          available_creators: available_creators
        )
    end
  end

  def show(conn, %{"id" => id}) do
    resource = Resources.get_resource_with_creator_and_tags!(id)
    render(conn, :show, resource: resource)
  end

  def edit(conn, %{"id" => id}) do
    resource = Resources.get_resource_with_creator_and_tags!(id)
    changeset = Resources.change_resource(resource)
    available_tags = Tags.list_tags()
    available_creators = Creators.list_creators()

    dbg(available_creators)

    render(conn, :edit,
      resource: resource,
      changeset: changeset,
      available_tags: available_tags,
      selected_tags: resource.tags,
      available_creators: available_creators
    )
  end

  def update(conn, %{"id" => id, "resource" => resource_params}) do
    resource = Resources.get_resource_with_creator_and_tags!(id)

    case Resources.update_resource(resource, resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource updated successfully.")
        |> redirect(to: ~p"/admins/resources/#{resource}")

      {:error, %Ecto.Changeset{} = changeset} ->
        available_tags = Tags.list_tags()
        available_creators = Creators.list_creators()

        render(conn, :edit,
          resource: resource,
          changeset: changeset,
          available_tags: available_tags,
          selected_tags: resource.tags,
          available_creators: available_creators
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    resource = Resources.get_resource!(id)
    {:ok, _resource} = Resources.delete_resource(resource)

    conn
    |> put_flash(:info, "Resource deleted successfully.")
    |> redirect(to: ~p"/admins/resources")
  end
end
