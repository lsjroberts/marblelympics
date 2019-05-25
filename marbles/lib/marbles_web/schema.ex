defmodule MarblesWeb.Schema do
  use Absinthe.Schema

  alias MarblesWeb.CompetitorsResolver
  alias MarblesWeb.EventsResolver
  alias MarblesWeb.MarblesResolver
  alias MarblesWeb.OccasionsResolver
  alias MarblesWeb.TeamsResolver

  object :occasion do
    field(:id, non_null(:id))
    field(:name, non_null(:string))

    field :events, list_of(non_null(:event)) do
      resolve(&EventsResolver.list_events/3)
    end

    field :teams, list_of(non_null(:team)) do
      resolve(&TeamsResolver.list_teams/3)
    end

    field :competitors, list_of(non_null(:competitor)) do
      resolve(&CompetitorsResolver.list_competitors/3)
    end
  end

  object :event do
    field(:id, non_null(:id))
    field(:name, non_null(:string))

    field :occasions, list_of(non_null(:occasion)) do
      resolve(&OccasionsResolver.list_occasions/3)
    end
  end

  object :team do
    field(:id, non_null(:id))
    field(:name, non_null(:string))

    field :marbles, list_of(non_null(:marble)) do
      resolve(&MarblesResolver.list_marbles/3)
    end
  end

  object :marble do
    field(:id, non_null(:id))
    field(:name, non_null(:string))

    field :events, list_of(non_null(:competitor)) do
      resolve(&CompetitorsResolver.list_competitors/3)
    end

    field :team, non_null(:team) do
      resolve(&TeamsResolver.get_team/3)
    end
  end

  object :competitor do
    field(:id, non_null(:id))
    field(:score, :integer)
    field(:points, :integer)

    field :event, non_null(:event) do
      resolve(&EventsResolver.get_event/3)
    end

    field :marble, non_null(:marble) do
      resolve(&MarblesResolver.get_marble/3)
    end

    field :occasion, non_null(:occasion) do
      resolve(&OccasionsResolver.get_occasion/3)
    end

    field :team, non_null(:team) do
      resolve(&TeamsResolver.get_team/3)
    end
  end

  query do
    field(:occasions, list_of(non_null(:occasion))) do
      resolve(&OccasionsResolver.list_occasions/3)
    end

    field(:occasion, :occasion) do
      arg(:id, non_null(:id))
      arg(:event, :id)
      resolve(&OccasionsResolver.get_occasion/3)
    end

    field(:events, non_null(list_of(non_null(:event)))) do
      resolve(&EventsResolver.list_events/3)
    end

    field(:teams, non_null(list_of(non_null(:team)))) do
      resolve(&TeamsResolver.list_teams/3)
    end

    field(:team, :team) do
      arg(:id, non_null(:id))
      resolve(&TeamsResolver.get_team/3)
    end

    field(:marbles, non_null(list_of(non_null(:marble)))) do
      resolve(&MarblesResolver.list_marbles/3)
    end

    field(:competitors, non_null(list_of(non_null(:competitor)))) do
      arg(:event, :id)
      arg(:marble, :id)
      resolve(&CompetitorsResolver.list_competitors/3)
    end
  end
end
