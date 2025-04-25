defmodule ChatappNew.ChatTest do
  use ChatappNew.DataCase

  alias ChatappNew.Chat

  describe "channel" do
    alias ChatappNew.Chat.Channels

    import ChatappNew.ChatFixtures

    @invalid_attrs %{name: nil, description: nil, is_private: nil}

    test "list_channel/0 returns all channel" do
      channels = channels_fixture()
      assert Chat.list_channel() == [channels]
    end

    test "get_channels!/1 returns the channels with given id" do
      channels = channels_fixture()
      assert Chat.get_channels!(channels.id) == channels
    end

    test "create_channels/1 with valid data creates a channels" do
      valid_attrs = %{name: "some name", description: "some description", is_private: true}

      assert {:ok, %Channels{} = channels} = Chat.create_channels(valid_attrs)
      assert channels.name == "some name"
      assert channels.description == "some description"
      assert channels.is_private == true
    end

    test "create_channels/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_channels(@invalid_attrs)
    end

    test "update_channels/2 with valid data updates the channels" do
      channels = channels_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", is_private: false}

      assert {:ok, %Channels{} = channels} = Chat.update_channels(channels, update_attrs)
      assert channels.name == "some updated name"
      assert channels.description == "some updated description"
      assert channels.is_private == false
    end

    test "update_channels/2 with invalid data returns error changeset" do
      channels = channels_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_channels(channels, @invalid_attrs)
      assert channels == Chat.get_channels!(channels.id)
    end

    test "delete_channels/1 deletes the channels" do
      channels = channels_fixture()
      assert {:ok, %Channels{}} = Chat.delete_channels(channels)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_channels!(channels.id) end
    end

    test "change_channels/1 returns a channels changeset" do
      channels = channels_fixture()
      assert %Ecto.Changeset{} = Chat.change_channels(channels)
    end
  end
end
