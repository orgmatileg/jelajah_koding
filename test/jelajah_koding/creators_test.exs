defmodule JelajahKoding.CreatorsTest do
  use JelajahKoding.DataCase

  alias JelajahKoding.Creators

  describe "creators" do
    alias JelajahKoding.Creators.Creator

    import JelajahKoding.CreatorsFixtures

    @invalid_attrs %{name: nil, url: nil}

    test "list_creators/0 returns all creators" do
      creator = creator_fixture()
      assert Creators.list_creators() == [creator]
    end

    test "get_creator!/1 returns the creator with given id" do
      creator = creator_fixture()
      assert Creators.get_creator!(creator.id) == creator
    end

    test "create_creator/1 with valid data creates a creator" do
      valid_attrs = %{name: "some name", url: "some url"}

      assert {:ok, %Creator{} = creator} = Creators.create_creator(valid_attrs)
      assert creator.name == "some name"
      assert creator.url == "some url"
    end

    test "create_creator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Creators.create_creator(@invalid_attrs)
    end

    test "update_creator/2 with valid data updates the creator" do
      creator = creator_fixture()
      update_attrs = %{name: "some updated name", url: "some updated url"}

      assert {:ok, %Creator{} = creator} = Creators.update_creator(creator, update_attrs)
      assert creator.name == "some updated name"
      assert creator.url == "some updated url"
    end

    test "update_creator/2 with invalid data returns error changeset" do
      creator = creator_fixture()
      assert {:error, %Ecto.Changeset{}} = Creators.update_creator(creator, @invalid_attrs)
      assert creator == Creators.get_creator!(creator.id)
    end

    test "delete_creator/1 deletes the creator" do
      creator = creator_fixture()
      assert {:ok, %Creator{}} = Creators.delete_creator(creator)
      assert_raise Ecto.NoResultsError, fn -> Creators.get_creator!(creator.id) end
    end

    test "change_creator/1 returns a creator changeset" do
      creator = creator_fixture()
      assert %Ecto.Changeset{} = Creators.change_creator(creator)
    end
  end
end
