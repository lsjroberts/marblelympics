defmodule MarblesWeb.Schema do
  use Absinthe.Schema

  alias MarblesWeb.EventsResolver
  alias MarblesWeb.OccasionsResolver

  object :occasion do
    field(:id, non_null(:id))
    field(:name, non_null(:string))

    field :events, list_of(non_null(:event)) do
      resolve(&EventsResolver.list_events/3)
    end
  end

  object :event do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    # field(:occasions, list_of(non_null(:occasion)))
  end

  query do
    field(:occasions, list_of(non_null(:occasion))) do
      resolve(&OccasionsResolver.list_occasions/3)
    end

    field(:occasion, :occasion) do
      arg(:id, non_null(:id))
      resolve(&OccasionsResolver.get_occasion/3)
    end

    field(:events, non_null(list_of(non_null(:event)))) do
      resolve(&EventsResolver.list_events/3)
    end
  end
end
