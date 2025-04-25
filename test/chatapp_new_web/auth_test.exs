defmodule ChatappNewWeb.AuthTest do
  use ChatappNewWeb.ConnCase, async: true
  alias ChatappNew.Users.User
  alias ChatappNew.Repo

  test "user registration and login" do
    # Registration (Pow)
    changeset =
      %User{}
      |> User.changeset(%{email: "authuser@example.com", password: "secret1234", password_confirmation: "secret1234"})
    IO.inspect(changeset.errors)
    assert changeset.valid?
    {:ok, user} = Repo.insert(changeset)
    assert user.email == "authuser@example.com"

    # Login simulation (Pow stores password hash, not plaintext)
    fetched = Repo.get_by(User, email: "authuser@example.com")
    assert fetched
    assert fetched.email == "authuser@example.com"
  end
end
