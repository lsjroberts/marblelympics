defmodule MarblesWeb.Schema do
  use Absinthe.Schema

  alias MarblesWeb.CompetitorsResolver
  alias MarblesWeb.EventsResolver
  alias MarblesWeb.MarblesResolver
  alias MarblesWeb.OccasionsResolver
  alias MarblesWeb.OccasionEventsResolver
  alias MarblesWeb.SeriesResolver
  alias MarblesWeb.TeamsResolver

  object :occasion do
    field(:id, non_null(:id))
    field(:name, non_null(:string))

    field :occasion_events, list_of(non_null(:occasion_event)) do
      resolve(&OccasionEventsResolver.list_occasion_events/3)
    end

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

    field :competitors, list_of(non_null(:competitor)) do
      resolve(&CompetitorsResolver.list_competitors/3)
    end
  end

  object :occasion_event do
    field(:date, non_null(:string))
    field(:event_id, non_null(:id))
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

    field :competitions, list_of(non_null(:competitor)) do
      resolve(&CompetitorsResolver.list_competitors/3)
    end

    field :team, non_null(:team) do
      resolve(&TeamsResolver.get_team/3)
    end
  end

  object :competitor do
    field(:id, non_null(:id))
    field(:score, non_null(list_of(non_null(:integer))))
    field(:points, non_null(:integer))
    field(:event_id, non_null(:id))
    field(:marble_id, non_null(:id))
    field(:occasion_id, non_null(:id))
    field(:team_id, non_null(:id))

    field :event, :event do
      resolve(&EventsResolver.get_event/3)
    end

    field :marble, :marble do
      resolve(&MarblesResolver.get_marble/3)
    end

    field :occasion, :occasion do
      resolve(&OccasionsResolver.get_occasion/3)
    end

    field :team, :team do
      resolve(&TeamsResolver.get_team/3)
    end
  end

  # object :team_result do
  #   field(:team, :team)
  #   field(:results, list_of(:result))
  # end

  # object :result do
  #   field(:event, :event)
  #   field(:occasion_event, :occasion_event)
  #   # field(:marbles, list_of(:marble))
  #   field(:score, list_of(:integer))
  #   field(:points, :integer)
  # end

  object :occasion_results do
    field(:event, non_null(:event))
    field(:occasion_event, non_null(:occasion_event))
    field(:results, non_null(list_of(non_null(:occasion_result))))
  end

  object :occasion_result do
    field(:team, non_null(:team))
    field(:score, non_null(list_of(non_null(:integer))))
    field(:points, non_null(:integer))
  end

  object :occasion_results_team do
    field(:team, non_null(:team))
    field(:results, non_null(list_of(non_null(:occasion_team_result))))
  end

  object :occasion_team_result do
    field(:rank, non_null(:integer))
    field(:points, non_null(:integer))
    field(:cumulative_rank, non_null(:integer))
    field(:cumulative_points, non_null(:integer))
    field(:event, non_null(:event))
    field(:occasion_event, non_null(:occasion_event))
  end

  query do
    field(:occasions, non_null(list_of(non_null(:occasion)))) do
      resolve(&OccasionsResolver.list_occasions/3)
    end

    field(:occasion, :occasion) do
      arg(:id, non_null(:id))
      arg(:event, :id)
      resolve(&OccasionsResolver.get_occasion/3)
    end

    field(:events, non_null(list_of(non_null(:event)))) do
      arg(:occasion, :id)
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
      arg(:team, :integer)
      resolve(&MarblesResolver.list_marbles/3)
    end

    field(:marble, :marble) do
      arg(:id, non_null(:id))
      resolve(&MarblesResolver.get_marble/3)
    end

    field(:competitors, non_null(list_of(non_null(:competitor)))) do
      arg(:event, :id)
      arg(:marble, :id)
      arg(:occasion, :id)
      resolve(&CompetitorsResolver.list_competitors/3)
    end

    # Data for charts
    # field(:team_results_series, non_null(list_of(non_null(:team_result)))) do
    #   arg(:occasion, non_null(:id))
    #   resolve(&SeriesResolver.occasion_results/3)
    # end

    field(:occasion_results, non_null(list_of(non_null(:occasion_results)))) do
      arg(:occasion, non_null(:id))
      resolve(&SeriesResolver.occasion_results/3)
    end

    field(:occasion_results_by_team, non_null(list_of(non_null(:occasion_results_team)))) do
      arg(:occasion, non_null(:id))
      resolve(&SeriesResolver.occasion_results_series/3)
    end
  end
end
