defmodule ExMon.Trainer do
  use Ecto.Schema
  import Ecto.Changeset

  #We need to do that because we aren't using integer to id
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    timestamps()
  end

  @required_params [:name, :password]
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    # change/2 take the given changeset and adds a new change
    change(changeset, Argon2.add_hash(password))
  end
  defp put_password_hash(changeset), do: changeset
end
