defmodule JelajahKoding.ResourcesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JelajahKoding.Resources` context.
  """

  @doc """
  Generate a resource.
  """
  def resource_fixture(attrs \\ %{}) do
    {:ok, resource} =
      attrs
      |> Enum.into(%{
        description: "some description",
        is_free: true,
        platform: "some platform",
        title: "some title"
      })
      |> JelajahKoding.Resources.create_resource()

    resource
  end
end
