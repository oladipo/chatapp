defmodule ChatappNew.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChatappNew.Chat` context.
  """

  @doc """
  Generate a channels.
  """
  def channels_fixture(attrs \\ %{}) do
    {:ok, channels} =
      attrs
      |> Enum.into(%{
        description: "some description",
        is_private: true,
        name: "some name"
      })
      |> ChatappNew.Chat.create_channels()

    channels
  end
end
