defmodule GlookoWeb.ApiSpec do
  @moduledoc "Api spec for openapi"

  alias OpenApiSpex.{Info, OpenApi, Paths, Server}
  alias GlookoWeb.{Endpoint, Router}
  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      servers: [
        Server.from_endpoint(Endpoint)
      ],
      info: %Info{
        title: "Tech interview",
        version: "0.1"
      },
      paths: Paths.from_router(Router)
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
