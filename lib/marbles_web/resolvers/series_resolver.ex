defmodule MarblesWeb.SeriesResolver do
  alias Marbles.{Competitors, Occasions, OccasionEvents, Repo, Teams}

  def occasion_results_series(_root, %{occasion: occasion_id}, _) do
    occasion = Repo.preload(Occasions.get_occasion!(occasion_id), [:events])
    occasion_events = OccasionEvents.list_occasion_events(occasion, nil)
    competitors = Competitors.list_competitors()
    teams = Teams.list_teams()

    ranked_points = [25, 20, 15, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

    out =
      Enum.map(teams, fn team ->
        results =
          Enum.filter(
            Enum.map(occasion.events, fn event ->
              occasion_event =
                Enum.find(occasion_events, fn oe ->
                  oe.occasion_id == occasion.id and oe.event_id == event.id
                end)

              competitor =
                Enum.find(competitors, fn c ->
                  c.occasion_id == occasion.id and
                    c.event_id == event.id and
                    c.team_id == team.id
                end)

              if competitor != nil do
                %{
                  event: event,
                  occasion_event: occasion_event,
                  rank: Enum.find_index(ranked_points, fn p -> p == competitor.points end) + 1,
                  points: competitor.points
                  # cumulative_points: competitor.points,
                  # cumulative_rank: 0
                }
              end
            end),
            fn r -> r != nil end
          )

        cumulative_points =
          Enum.reverse(
            Enum.reduce(results, [0], fn r, acc ->
              [head | _] = acc
              [head + r.points | acc]
            end)
          )

        results_with_c =
          Enum.map(Enum.with_index(results), fn {r, k} ->
            Map.put(r, :cumulative_points, Enum.at(cumulative_points, k + 1))
          end)

        %{
          team: team,
          results: results_with_c
        }
      end)

    {:ok, out}
  end

  def occasion_results(_root, %{occasion: occasion_id}, _) do
    occasion = Repo.preload(Occasions.get_occasion!(occasion_id), [:events])
    occasion_events = OccasionEvents.list_occasion_events(occasion, nil)
    teams = Teams.list_teams()

    out =
      Enum.map(occasion.events, fn event ->
        competitors = Competitors.list_competitors(event, %{occasion: occasion.id})

        occasion_event =
          Enum.find(occasion_events, fn oe ->
            oe.occasion_id == occasion.id and oe.event_id == event.id
          end)

        results =
          Enum.map(competitors, fn competitor ->
            team = Enum.find(teams, fn t -> t.id == competitor.team_id end)
            %{team: team, score: competitor.score, points: competitor.points}
          end)

        %{
          occasion_event: occasion_event,
          event: event,
          results: results
        }
      end)

    {:ok, out}
  end

  def occasion_results_old(_root, %{occasion: occasion_id}, _) do
    occasion = Occasions.get_occasion!(occasion_id)
    occasion_events = OccasionEvents.list_occasion_events(occasion, nil)
    competitors = Competitors.list_competitors(occasion, nil)

    results =
      Enum.map(competitors, fn c ->
        cl = Repo.preload(c, [:event, :team])

        %{
          team: cl.team,
          results: [
            %{
              event: cl.event,
              # marbles: cl.marble,
              score: c.score,
              points: c.points
            }
          ]
        }
      end)

    {:ok, results}
  end
end
