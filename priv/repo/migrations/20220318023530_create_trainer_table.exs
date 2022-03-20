defmodule ExMon.Repo.Migrations.CreateTrainerTable do
  use Ecto.Migration

  def change do
    # Normally Ecto uses create and uses integer as primary_key by default
    # but we want to use UUID so we can pass primary_key: false
    create table(:trainers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :password_hash, :string
      #Automatically add columns inserted_at and updated_at
      timestamps()
    end
  end
end
