module Visualisations exposing (occasionResultsByTeam)

import Api.Scalar exposing (Id(..))
import Element exposing (Element)
import Html
import LineChart
import LineChart.Area as Area
import LineChart.Axis as Axis
import LineChart.Axis.Intersection as Intersection
import LineChart.Colors as Colors
import LineChart.Container as Container
import LineChart.Dots as Dots
import LineChart.Events as Events
import LineChart.Grid as Grid
import LineChart.Interpolation as Interpolation
import LineChart.Junk as Junk
import LineChart.Legends as Legends
import LineChart.Line as Line
import List.Extra


type alias Team =
    { id : Id
    , name : String
    , marbles : Maybe (List Marble)
    }


type alias Marble =
    { id : Id
    , name : String
    , competitions : Maybe (List Competitor)
    }


type alias Competitor =
    { points : Int
    , score : List Int
    , eventId : Id
    , marbleId : Id
    , occasionId : Id
    , teamId : Id
    }


type alias Event =
    { id : Id
    , name : String
    }


type alias OccasionEvent =
    { eventId : Id
    , date : String
    }


type alias OccasionResultsByTeam =
    { team : Team
    , results : List OccasionTeamResult
    }


type alias OccasionTeamResult =
    { event : Event
    , occasionEvent : OccasionEvent
    , rank : Int
    , points : Int
    , cumulativePoints : Int
    }


colors =
    [ Colors.blue
    , Colors.blueLight
    , Colors.cyan
    , Colors.cyanLight
    , Colors.teal
    , Colors.tealLight
    , Colors.green
    , Colors.greenLight
    , Colors.gold
    , Colors.goldLight
    , Colors.pink
    , Colors.pinkLight
    , Colors.red
    , Colors.redLight
    , Colors.purple
    , Colors.purpleLight
    , Colors.rust
    , Colors.strongBlue
    ]


occasionResultsByTeam : List OccasionResultsByTeam -> Element msg
occasionResultsByTeam results =
    let
        series =
            results
                |> List.indexedMap
                    (\j r ->
                        ( r.team.name
                        , r.results
                            |> List.indexedMap (\i { cumulativePoints } -> { x = toFloat i, y = toFloat cumulativePoints })
                        , Maybe.withDefault Colors.cyan <| List.Extra.getAt j colors
                        )
                    )

        lines =
            series |> List.map (\( s, ds, color ) -> LineChart.line color Dots.circle s ds)
    in
    Element.html <|
        Html.div []
            [ LineChart.viewCustom chartConfig lines ]


chartConfig =
    { y = Axis.default 400 "Points" .y
    , x = Axis.default 1024 "" .x
    , container = Container.default "line-chart-1"
    , interpolation = Interpolation.default
    , intersection = Intersection.default
    , legends = Legends.default
    , events = Events.default
    , junk = Junk.default
    , grid = Grid.default
    , area = Area.default
    , line = Line.default
    , dots = Dots.default
    }



-- let
--         teams =
--             competitors
--                 |> List.map
--                     (\c ->
--                         case c.teamId of
--                             Id id ->
--                                 id
--                     )
--                 |> List.Extra.unique
--         series =
--             teams
--                 |> List.map
--                     (\t ->
--                         ( t
--                         , competitors
--                             |> List.filter (\c -> Id t == c.teamId)
--                             |> List.map
--                                 (\c ->
--                                     { points = toFloat c.points
--                                     , event =
--                                         events
--                                             |> List.Extra.find (\e -> e.id == c.eventId)
--                                             |> Maybe.andThen
--                                                 (\e ->
--                                                     Just e.date
--                                                 )
--                                             |> Maybe.withDefault ""
--                                     }
--                                 )
--                         )
--                     )
