defmodule Inmana.Repo.Migrations.CreateSuppliesTable do
  use Ecto.Migration

  def change do
    create table(:supplies) do
      # add é uma macro oferecita pelo Ecto.Migration
      add :description, :string
      add :expiration_date, :date
      add :responsible, :string
      add :restaurant_id, references(:restaurants, type: :binary_id)

      timestamps()
    end
  end
end
