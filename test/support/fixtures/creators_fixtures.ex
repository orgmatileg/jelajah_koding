defmodule JelajahKoding.CreatorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JelajahKoding.Creators` context.
  """

  @doc """
  Generate a creator.
  """
  def creator_fixture(attrs \\ %{}) do
    {:ok, creator} =
      attrs
      |> Enum.into(%{
        name: "some name",
        url: "some url"
      })
      |> JelajahKoding.Creators.create_creator()

    creator
  end
end
