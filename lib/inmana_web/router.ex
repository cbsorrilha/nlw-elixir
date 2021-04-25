defmodule InmanaWeb.Router do
  use InmanaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {InmanaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InmanaWeb do
    pipe_through :api

    get "/", WelcomeController, :index

    post "/restaurants", RestaurantsController, :create
    # Cria todas as rotas de uma api rest
    resources "/supplies", SuppliesController, only: [:create, :show]
  end

  scope "/", InmanaWeb do
    # Use the default browser stack
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/dash" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: InmanaWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
