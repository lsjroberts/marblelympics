defmodule MarblesWeb.Router do
  use MarblesWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
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
