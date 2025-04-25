defmodule ChatappNew.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  alias ChatappNew.Repo

  alias ChatappNew.Chat.Channels
  alias ChatappNew.Chat.Message

  @doc """
  Returns the list of channel.

  ## Examples

      iex> list_channel()
      [%Channels{}, ...]

  """
  def list_channel do
    Repo.all(Channels)
  end

  @doc """
  Gets a single channels.

  Raises `Ecto.NoResultsError` if the Channels does not exist.

  ## Examples

      iex> get_channels!(123)
      %Channels{}

      iex> get_channels!(456)
      ** (Ecto.NoResultsError)

  """
  def get_channels!(id), do: Repo.get!(Channels, id)

  @doc """
  Gets a single channel.

  Raises `Ecto.NoResultsError` if the Channels does not exist.

  ## Examples

      iex> get_channel!(123)
      %Channels{}

      iex> get_channel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_channel!(id), do: get_channels!(id)

  @doc """
  Creates a channels.

  ## Examples

      iex> create_channels(%{field: value})
      {:ok, %Channels{}}

      iex> create_channels(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_channels(attrs \\ %{}) do
    %Channels{}
    |> Channels.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> ChatappNew.Repo.insert()
  end

  @doc """
  Updates a channels.

  ## Examples

      iex> update_channels(channels, %{field: new_value})
      {:ok, %Channels{}}

      iex> update_channels(channels, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_channels(%Channels{} = channels, attrs) do
    channels
    |> Channels.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a channels.

  ## Examples

      iex> delete_channels(channels)
      {:ok, %Channels{}}

      iex> delete_channels(channels)
      {:error, %Ecto.Changeset{}}

  """
  def delete_channels(%Channels{} = channels) do
    Repo.delete(channels)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking channels changes.

  ## Examples

      iex> change_channels(channels)
      %Ecto.Changeset{data: %Channels{}}

  """
  def change_channels(%Channels{} = channels, attrs \\ %{}) do
    Channels.changeset(channels, attrs)
  end

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  @doc """
  Returns the list of messages for a channel.

  ## Examples

      iex> list_messages_for_channel(123)
      [%Message{}, ...]

  """
  def list_messages_for_channel(channel_id) do
    import Ecto.Query
    Message
    |> where([m], m.channel_id == ^channel_id)
    |> ChatappNew.Repo.all()
  end
end
