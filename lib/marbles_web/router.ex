defmodule MarblesWeb.Router do
  use MarblesWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(CORSPlug)
  end

  scope "/api" do
    pipe_through(:api)

    forward("/", Absinthe.Plug,
      schema: MarblesWeb.Schema,
      analyze_complexity: true,
      max_complexity: 1000,
      json_codec: Jason
    )
  end

  scope "/" do
    pipe_through(:api)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: MarblesWeb.Schema,
      interface: :simple,
      context: %{pubsub: MarblesWeb.Endpoint}
    )
  end
end
