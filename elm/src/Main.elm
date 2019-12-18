module Main exposing (Model, Msg(..), init, main, update, view)

import Api.Object
import Api.Object.Competitor as Competitor
import Api.Object.Event as Event
import Api.Object.Marble as Marble
import Api.Object.Occasion as Occasion
import Api.Object.OccasionEvent as OccasionEvent
import Api.Object.OccasionResult as OccasionResult
import Api.Object.OccasionResults as OccasionResults
import Api.Object.OccasionResultsTeam as OccasionResultsTeam
import Api.Object.OccasionTeamResult as OccasionTeamResult
import Api.Object.Team as Team
import Api.Query as Query
import Api.Scalar exposing (Id(..))
import Browser
import Browser.Navigation as Nav
import Dict exposing (Dict)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Http
import Maybe.Extra as Maybe
import RemoteData exposing (RemoteData)
import Url
import Url.Parser as Parser exposing ((</>), Parser, custom, fragment, map, oneOf, s, top)
import Visualisations



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }



---- MODEL ----


type alias Model =
    { key : Nav.Key
    , page : Page
    , occasions : RemoteData (Graphql.Http.RawError () Http.Error) (List Occasion)
    , occasion : RemoteData (Graphql.Http.RawError () Http.Error) (Maybe Occasion)
    , teams : RemoteData (Graphql.Http.RawError () Http.Error) (List Team)
    , team : RemoteData (Graphql.Http.RawError () Http.Error) (Maybe Team)
    , marbles : RemoteData (Graphql.Http.RawError () Http.Error) (List Marble)
    , marble : RemoteData (Graphql.Http.RawError () Http.Error) (Maybe Marble)
    , occasionResults : RemoteData (Graphql.Http.RawError () Http.Error) (List OccasionResults)
    , occasionResultsByTeam : RemoteData (Graphql.Http.RawError () Http.Error) (List OccasionResultsByTeam)
    }


type Page
    = NotFound
    | HomePage
    | OccasionPage
    | TeamPage
    | MarblePage


type alias Occasion =
    { id : Id
    , name : String
    , events : Maybe (List Event)
    , teams : Maybe (List Team)
    , competitors : Maybe (List Competitor)
    , occasionEvents : Maybe (List OccasionEvent)
    }


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


type alias OccasionResults =
    { occasionEvent : OccasionEvent
    , event : Event
    , results : List OccasionResult
    }


type alias OccasionResult =
    { team : Team
    , score : List Int
    , points : Int
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


queryOccasions : SelectionSet (List Occasion) RootQuery
queryOccasions =
    Query.occasions
        (occasionSelection
            |> hardcoded Nothing
            |> hardcoded Nothing
            |> hardcoded Nothing
            |> hardcoded Nothing
        )


queryOccasion : Id -> SelectionSet (Maybe Occasion) RootQuery
queryOccasion id =
    Query.occasion identity
        { id = id }
        (occasionSelection
            |> with (Occasion.events eventSelection)
            |> with (Occasion.teams (teamSelection |> hardcoded Nothing))
            |> with (Occasion.competitors competitorSelection)
            |> with (Occasion.occasionEvents occasionEventSelection)
        )


queryTeams : SelectionSet (List Team) RootQuery
queryTeams =
    Query.teams (teamSelection |> hardcoded Nothing)


queryTeam : Id -> SelectionSet (Maybe Team) RootQuery
queryTeam id =
    Query.team { id = id } (teamSelection |> hardcoded Nothing)


queryTeamWithMarbles : Id -> SelectionSet (Maybe Team) RootQuery
queryTeamWithMarbles id =
    Query.team { id = id }
        (teamSelection |> with (Team.marbles (marbleSelection |> hardcoded Nothing)))


queryMarbles : SelectionSet (List Marble) RootQuery
queryMarbles =
    Query.marbles identity
        (marbleSelection |> hardcoded Nothing)


queryMarble : Id -> SelectionSet (Maybe Marble) RootQuery
queryMarble id =
    Query.marble { id = id }
        (marbleSelection |> hardcoded Nothing)


queryMarbleWithCompetitions : Id -> SelectionSet (Maybe Marble) RootQuery
queryMarbleWithCompetitions id =
    Query.marble { id = id }
        (marbleSelection |> with (Marble.competitions competitorSelection))


queryOccasionResults : Id -> SelectionSet (List OccasionResults) RootQuery
queryOccasionResults id =
    Query.occasionResults { occasion = id } occasionResultsSelection


queryOccasionResultsByTeam : Id -> SelectionSet (List OccasionResultsByTeam) RootQuery
queryOccasionResultsByTeam id =
    Query.occasionResultsByTeam { occasion = id } occasionResultsByTeamSelection


occasionSelection =
    SelectionSet.succeed Occasion
        |> with Occasion.id
        |> with Occasion.name


eventSelection =
    SelectionSet.succeed Event
        |> with Event.id
        |> with Event.name


teamSelection =
    SelectionSet.succeed Team
        |> with Team.id
        |> with Team.name


marbleSelection =
    SelectionSet.succeed Marble
        |> with Marble.id
        |> with Marble.name


competitorSelection =
    SelectionSet.succeed Competitor
        |> with Competitor.points
        |> with Competitor.score
        |> with Competitor.eventId
        |> with Competitor.marbleId
        |> with Competitor.occasionId
        |> with Competitor.teamId


occasionEventSelection =
    SelectionSet.succeed OccasionEvent
        |> with OccasionEvent.eventId
        |> with OccasionEvent.date


occasionResultsSelection =
    SelectionSet.succeed OccasionResults
        |> with (OccasionResults.occasionEvent occasionEventSelection)
        |> with (OccasionResults.event eventSelection)
        |> with (OccasionResults.results occasionResultSelection)


occasionResultSelection =
    SelectionSet.succeed OccasionResult
        |> with (OccasionResult.team (teamSelection |> hardcoded Nothing))
        |> with OccasionResult.score
        |> with OccasionResult.points


occasionResultsByTeamSelection =
    SelectionSet.succeed OccasionResultsByTeam
        |> with (OccasionResultsTeam.team (teamSelection |> hardcoded Nothing))
        |> with (OccasionResultsTeam.results occasionTeamResultSelection)


occasionTeamResultSelection =
    SelectionSet.succeed OccasionTeamResult
        |> with (OccasionTeamResult.event eventSelection)
        |> with (OccasionTeamResult.occasionEvent occasionEventSelection)
        |> with OccasionTeamResult.rank
        |> with OccasionTeamResult.points
        |> with OccasionTeamResult.cumulativePoints


query : SelectionSet decodeTo RootQuery -> (RemoteData (Graphql.Http.RawError () Http.Error) decodeTo -> Msg) -> Cmd Msg
query queryConstructor msg =
    queryConstructor
        |> Graphql.Http.queryRequest "http://localhost:4000/api"
        |> Graphql.Http.send
            (Graphql.Http.parseableErrorAsSuccess
                >> Graphql.Http.withSimpleHttpError
                >> RemoteData.fromResult
                >> msg
            )


init : Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init url key =
    changeUrlTo url
        { key = key
        , page = HomePage
        , occasions = RemoteData.NotAsked
        , occasion = RemoteData.NotAsked
        , teams = RemoteData.NotAsked
        , team = RemoteData.NotAsked
        , marbles = RemoteData.NotAsked
        , marble = RemoteData.NotAsked
        , occasionResults = RemoteData.NotAsked
        , occasionResultsByTeam = RemoteData.NotAsked
        }



---- UPDATE ----


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotOccasions (RemoteData (Graphql.Http.RawError () Http.Error) (List Occasion))
    | GotOccasion (RemoteData (Graphql.Http.RawError () Http.Error) (Maybe Occasion))
    | GotTeams (RemoteData (Graphql.Http.RawError () Http.Error) (List Team))
    | GotTeam (RemoteData (Graphql.Http.RawError () Http.Error) (Maybe Team))
    | GotMarbles (RemoteData (Graphql.Http.RawError () Http.Error) (List Marble))
    | GotMarble (RemoteData (Graphql.Http.RawError () Http.Error) (Maybe Marble))
    | GotOccasionResults (RemoteData (Graphql.Http.RawError () Http.Error) (List OccasionResults))
    | GotOccasionResultsByTeam (RemoteData (Graphql.Http.RawError () Http.Error) (List OccasionResultsByTeam))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotOccasions occasions ->
            ( { model | occasions = occasions }, Cmd.none )

        GotOccasion occasion ->
            ( { model | occasion = occasion }, Cmd.none )

        GotTeams teams ->
            ( { model | teams = teams }, Cmd.none )

        GotTeam team ->
            ( { model | team = team }, Cmd.none )

        GotMarbles marbles ->
            ( { model | marbles = marbles }, Cmd.none )

        GotMarble marble ->
            ( { model | marble = marble }, Cmd.none )

        GotOccasionResults occasionResults ->
            ( { model | occasionResults = occasionResults }, Cmd.none )

        GotOccasionResultsByTeam occasionResultsByTeam ->
            ( { model | occasionResultsByTeam = occasionResultsByTeam }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            changeUrlTo url model



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    case model.page of
        NotFound ->
            viewContainer { title = Just "Not Found", child = text "Not Found" }

        HomePage ->
            viewContainer { title = Nothing, child = viewHome model }

        OccasionPage ->
            viewContainer { title = Nothing, child = viewOccasion model }

        TeamPage ->
            viewContainer { title = Nothing, child = viewTeam model }

        MarblePage ->
            viewContainer { title = Nothing, child = viewMarble model }


viewContainer page =
    { title = Maybe.unwrap "MarbleLympics Stats" (\t -> t ++ " - " ++ "MarbleLympics Stats") page.title
    , body =
        [ layout [] <| page.child ]
    }


viewHome model =
    viewResponse model.occasions
        (\occasions ->
            column []
                (List.map
                    (\o ->
                        case o.id of
                            Id id ->
                                link []
                                    { url = "/occasion/" ++ id
                                    , label = text o.name
                                    }
                    )
                    occasions
                )
        )


viewOccasion : Model -> Element Msg
viewOccasion model =
    let
        success mo =
            Maybe.unwrap (text "Occasion not found") occasion mo

        occasion o =
            column [ spacing 40 ]
                [ text o.name
                , viewResponse model.occasionResultsByTeam Visualisations.occasionResultsByTeam

                -- , Maybe.unwrap (text "no teams") teams o.teams
                , viewResponse model.occasionResults viewOccasionTables
                ]

        -- marbles
        --     |> List.filter (\m -> m.id == c.marbleId)
        --     |> List.map
        --         (\m ->
        --             column [ spacing 2 ]
        --                 [ text m.name
        --                 , row [ spacing 10 ] (List.map (\s -> text (String.fromInt s)) c.score)
        --                 , text (String.fromInt c.points)
        --                 ]
        --         )
        --     |> column [ spacing 2 ]
    in
    viewResponse model.occasion success


viewOccasionTables : List OccasionResults -> Element Msg
viewOccasionTables values =
    let
        occasions =
            List.map occasion values

        occasion : OccasionResults -> ( Event, List ( Int, OccasionResult ) )
        occasion o =
            ( o.event, List.indexedMap (\i r -> ( i, r )) o.results )

        columns =
            -- [ { header = text "Rank"
            --   , view = \{ rank } -> text (String.fromInt rank)
            --   }
            [ { header = text "Team"
              , view = \{ team } -> text team.name
              }

            -- , { header = text "Marble"
            --   , view =
            --         \{ name, competitor } ->
            --             link []
            --                 { url =
            --                     case competitor.marbleId of
            --                         Id marbleId ->
            --                             "/marble/" ++ marbleId
            --                 , label = text name
            --                 }
            --   }
            , { header = text "One"
              , view =
                    \{ score } ->
                        case score of
                            x :: xs ->
                                text (String.fromInt x)

                            _ ->
                                text " "
              }
            , { header = text "Two"
              , view =
                    \{ score } ->
                        case score of
                            _ :: x :: xs ->
                                text (String.fromInt x)

                            _ ->
                                text " "
              }
            , { header = text "Three"
              , view =
                    \{ score } ->
                        case score of
                            _ :: _ :: x :: xs ->
                                text (String.fromInt x)

                            _ ->
                                text " "
              }
            , { header = text "Four"
              , view =
                    \{ score } ->
                        case score of
                            _ :: _ :: _ :: x :: xs ->
                                text (String.fromInt x)

                            _ ->
                                text " "
              }
            , { header = text "Results"
              , view =
                    \{ score } ->
                        -- case score of
                        --     _ :: _ :: x :: xs ->
                        --         text (String.fromInt x)
                        --     _ :: x :: xs ->
                        --         text (String.fromInt x)
                        --     x :: xs ->
                        --         text (String.fromInt x)
                        --     _ ->
                        text " "
              }
            , { header = text "Points"
              , view = \{ points } -> text (String.fromInt points)
              }
            ]
    in
    occasions
        |> List.map
            (\( event, data ) ->
                column []
                    [ text event.name
                    , styledTable []
                        { data = data
                        , columns = columns
                        }
                    ]
            )
        |> column [ spacing 100 ]


viewTeam model =
    let
        success t =
            column []
                [ text t.name
                , Maybe.unwrap (text "No marbles :(") marbles t.marbles
                ]

        marbles ms =
            column []
                (List.map
                    (\m ->
                        case m.id of
                            Id id ->
                                link []
                                    { url = "/marble/" ++ id
                                    , label = text m.name
                                    }
                    )
                    ms
                )
    in
    viewResponse model.team
        (Maybe.unwrap (text "Team does not exist") success)


viewMarble model =
    let
        marble m =
            column []
                [ text m.name
                , Maybe.unwrap (text "No competitions") competitions m.competitions
                ]

        competitions cs =
            column []
                (List.map
                    (\c ->
                        row [ spacing 10 ]
                            [ --Maybe.unwrap (text "no event?") (\e -> text e.name) c.event
                              text (String.fromInt c.points)
                            , row [ spacing 5 ] (List.map (\s -> text (String.fromInt s)) c.score)
                            ]
                    )
                    cs
                )
    in
    column []
        [ viewResponse model.marble
            (Maybe.unwrap (text "Marble does not exist") marble)
        ]


viewResponse : RemoteData e a -> (a -> Element Msg) -> Element Msg
viewResponse response success =
    case response of
        RemoteData.Loading ->
            text "loading"

        RemoteData.Success result ->
            success result

        RemoteData.Failure error ->
            text "error"

        RemoteData.NotAsked ->
            text "not asked"


styledTable attrs { columns, data } =
    table ([] ++ attrs)
        { data = data
        , columns =
            columns
                |> List.map
                    (\c ->
                        { header =
                            el
                                [ Background.color (rgb 0.92 0.92 0.92)
                                , Border.color (rgb 0.8 0.8 0.8)
                                , Border.widthEach { top = 0, right = 0, bottom = 1, left = 0 }
                                , padding 10
                                ]
                                c.header
                        , width = fill
                        , view =
                            \( i, d ) ->
                                el
                                    [ Background.color
                                        (if i == 0 then
                                            rgb (247 / 255) (223 / 255) (94 / 255)

                                         else if i == 1 then
                                            rgb (210 / 255) (202 / 255) (202 / 255)

                                         else if i == 2 then
                                            rgb (220 / 255) (186 / 255) (151 / 255)

                                         else if modBy 2 i == 0 then
                                            rgb 0.95 0.95 0.95

                                         else
                                            rgb 0.98 0.98 0.98
                                        )
                                    , padding 10
                                    ]
                                    (c.view d)
                        }
                    )
        }



--- ROUTER ---


changeUrlTo url model =
    let
        parser =
            oneOf
                [ route top (routeHome model)
                , route (s "occasion" </> Parser.string) (\occasion -> routeOccasion model occasion)
                , route (s "team" </> Parser.string) (\team -> routeTeam model team)
                , route (s "marble" </> Parser.string) (\marble -> routeMarble model marble)
                ]
    in
    case Parser.parse parser url of
        Just answer ->
            answer

        Nothing ->
            ( { model | page = NotFound }, Cmd.none )


route parser handler =
    Parser.map handler parser


routeHome model =
    ( { model | page = HomePage, occasions = RemoteData.Loading }
    , query queryOccasions GotOccasions
    )


routeOccasion model occasion =
    ( { model | page = OccasionPage, occasion = RemoteData.Loading, marbles = RemoteData.Loading }
    , Cmd.batch
        [ query (queryOccasion (Id occasion)) GotOccasion
        , query queryMarbles GotMarbles
        , query (queryOccasionResults (Id occasion)) GotOccasionResults
        , query (queryOccasionResultsByTeam (Id occasion)) GotOccasionResultsByTeam
        ]
    )


routeTeam model team =
    ( { model | page = TeamPage, team = RemoteData.Loading, marbles = RemoteData.Loading }
    , query (queryTeam (Id team)) GotTeam
    )


routeMarble model marble =
    ( { model | page = MarblePage, marble = RemoteData.Loading }
    , case String.toInt marble of
        Just id ->
            query (queryMarbleWithCompetitions (Id marble)) GotMarble

        Nothing ->
            Cmd.none
    )
