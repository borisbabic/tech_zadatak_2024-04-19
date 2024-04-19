defmodule GlookoWeb.Router do
  use GlookoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GlookoWeb do
    pipe_through :api
  end
end
