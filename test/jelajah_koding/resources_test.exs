defmodule JelajahKoding.ResourcesTest do
  use JelajahKoding.DataCase

  alias JelajahKoding.Resources

  describe "resources" do
    alias JelajahKoding.Resources.Resource

    import JelajahKoding.ResourcesFixtures

    @invalid_attrs %{description: nil, title: nil, platform: nil, is_free: nil}

    test "list_resources/0 returns all resources" do
      resource = resource_fixture()
      assert Resources.list_resources() == [resource]
    end

    test "get_resource!/1 returns the resource with given id" do
      resource = resource_fixture()
      assert Resources.get_resource!(resource.id) == resource
    end

    test "create_resource/1 with valid data creates a resource" do
      valid_attrs = %{description: "some description", title: "some title", platform: "some platform", is_free: true}

      assert {:ok, %Resource{} = resource} = Resources.create_resource(valid_attrs)
      assert resource.description == "some description"
      assert resource.title == "some title"
      assert resource.platform == "some platform"
      assert resource.is_free == true
    end

    test "create_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_resource(@invalid_attrs)
    end

    test "update_resource/2 with valid data updates the resource" do
      resource = resource_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", platform: "some updated platform", is_free: false}

      assert {:ok, %Resource{} = resource} = Resources.update_resource(resource, update_attrs)
      assert resource.description == "some updated description"
      assert resource.title == "some updated title"
      assert resource.platform == "some updated platform"
      assert resource.is_free == false
    end

    test "update_resource/2 with invalid data returns error changeset" do
      resource = resource_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_resource(resource, @invalid_attrs)
      assert resource == Resources.get_resource!(resource.id)
    end

    test "delete_resource/1 deletes the resource" do
      resource = resource_fixture()
      assert {:ok, %Resource{}} = Resources.delete_resource(resource)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_resource!(resource.id) end
    end

    test "change_resource/1 returns a resource changeset" do
      resource = resource_fixture()
      assert %Ecto.Changeset{} = Resources.change_resource(resource)
    end
  end
end
