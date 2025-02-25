defmodule JelajahKoding.Resources do
  @moduledoc """
  The Resources context.
  """

  import Ecto.Query, warn: false
  alias JelajahKoding.Repo

  alias JelajahKoding.Resources.Resource
  alias JelajahKoding.Tags.Tag

  def list_resources(%{"is_free" => is_free}) do
    Resource
    |> where([r], r.is_free == ^is_free)
    |> Repo.all()
    |> Repo.preload([:creator, :tags])
  end

  def list_resources(%{"tag" => tag}) do
    query =
      from r in JelajahKoding.Resources.Resource,
        join: t in assoc(r, :tags),
        where: t.id == ^tag,
        preload: [tags: t, creator: r]

    Repo.all(query)
    |> Repo.preload([:creator, :tags])
  end

  def list_resources(%{"title" => title}) do
    Resource
    |> where([r], ilike(r.title, ^"%#{title}%"))
    |> Repo.all()
    |> Repo.preload([:creator, :tags])
  end

  def list_resources do
    Resource
    |> Repo.all()
    |> Repo.preload([:creator, :tags])
  end

  @doc """
  Gets a single resource.

  Raises `Ecto.NoResultsError` if the Resource does not exist.

  ## Examples

      iex> get_resource!(123)
      %Resource{}

      iex> get_resource!(456)
      ** (Ecto.NoResultsError)

  """
  def get_resource!(id), do: Repo.get!(Resource, id) |> Repo.preload([:creator, :tags])

  def get_resource_with_creator_and_tags!(id) do
    Resource
    |> Repo.get!(id)
    |> Repo.preload([:creator, :tags])
  end

  @doc """
  Creates a resource.

  ## Examples

      iex> create_resource(%{field: value})
      {:ok, %Resource{}}

      iex> create_resource(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_resource(%{"tag_ids" => tag_ids} = attrs) when is_list(tag_ids) do
    # Fetch the tag structs based on the provided tag_ids
    tags = Repo.all(from t in Tag, where: t.id in ^tag_ids)

    # Merge the loaded tags into the attributes
    attrs = Map.put(attrs, "tags", tags)

    %Resource{}
    |> Resource.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, resource} -> {:ok, Repo.preload(resource, [:creator, :tags])}
      error -> error
    end
  end

  def create_resource(attrs) do
    %Resource{}
    |> Resource.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, resource} -> {:ok, Repo.preload(resource, [:creator, :tags])}
      error -> error
    end
  end

  @doc """
  Updates a resource.

  ## Examples

      iex> update_resource(resource, %{field: new_value})
      {:ok, %Resource{}}

      iex> update_resource(resource, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_resource(%Resource{} = resource, %{"tag_ids" => tag_ids} = attrs)
      when is_list(tag_ids) do
    # Fetch the tag structs based on the provided tag_ids
    tags = Repo.all(from t in Tag, where: t.id in ^tag_ids)

    # Merge the loaded tags into the attributes
    attrs = Map.put(attrs, "tags", tags)

    resource
    |> Resource.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, resource} -> {:ok, Repo.preload(resource, [:creator, :tags])}
      error -> error
    end
  end

  def update_resource(%Resource{} = resource, attrs) do
    resource
    |> Resource.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, resource} -> {:ok, Repo.preload(resource, [:creator, :tags])}
      error -> error
    end
  end

  @doc """
  Deletes a resource.

  ## Examples

      iex> delete_resource(resource)
      {:ok, %Resource{}}

      iex> delete_resource(resource)
      {:error, %Ecto.Changeset{}}

  """
  def delete_resource(%Resource{} = resource) do
    Repo.delete(resource)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking resource changes.

  ## Examples

      iex> change_resource(resource)
      %Ecto.Changeset{data: %Resource{}}

  """
  def change_resource(%Resource{} = resource, attrs \\ %{}) do
    resource
    |> Repo.preload([:creator, :tags])
    |> Resource.changeset(attrs)
  end
end
