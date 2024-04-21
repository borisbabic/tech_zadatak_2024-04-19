defmodule GlookoWeb.Router do
  use GlookoWeb, :router
  alias OpenApiSpex

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: GlookoWeb.ApiSpec
  end

  scope "/" do
    pipe_through :browser
    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/api/openapi"
  end

  scope "/api" do
    pipe_through :api
    get "/openapi", OpenApiSpex.Plug.RenderSpec, :show
    get "/graph/:user_id", GlookoWeb.GraphController, :index
    get "/calendar/:user_id", GlookoWeb.CalendarController, :index
  end
end
