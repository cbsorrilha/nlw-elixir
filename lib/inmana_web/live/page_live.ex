defmodule InmanaWeb.PageLive do
  use InmanaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 3000)

    restaurants = get_restaurants_with_supplies()
    {:ok, assign(socket, query: "", restaurants: restaurants)}
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 3000)
    restaurants = get_restaurants_with_supplies()
    {:noreply, assign(socket, :restaurants, restaurants)}
  end

  defp get_restaurants_with_supplies do
    {:ok, resturants} = Inmana.get_restaurants()
    resturants
  end
end
