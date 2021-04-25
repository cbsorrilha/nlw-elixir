defmodule Inmana.Restaurants.Get do
  alias Inmana.{Repo, Restaurant}

  def call do
    case Repo.all(Restaurant) |> Repo.preload(:supplies) do
      nil -> {:error, %{result: "No restaurants found", status: :not_found}}
      restaurant -> {:ok, restaurant}
    end
  end
end
