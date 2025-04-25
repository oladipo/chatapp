defmodule ChatappNewWeb.Router do
  use ChatappNewWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ChatappNewWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Pow.Plug.Session, otp_app: :chatapp_new
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Add Pow routes for authentication
  import Pow.Phoenix.Router

  scope "/" do
    pipe_through :browser
    pow_routes()
  end

  scope "/", ChatappNewWeb do
    pipe_through :browser
    live "/", ChatLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatappNewWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:chatapp_new, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ChatappNewWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
