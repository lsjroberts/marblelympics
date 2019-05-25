module Main exposing (Model, Msg(..), init, main, update, view)

import Api.Object
import Api.Object.Competitor as Competitor
import Api.Object.Event as Event
import Api.Object.Marble as Marble
import Api.Object.Occasion as Occasion
import Api.Object.Team as Team
import Api.Query as Query
import Api.Scalar exposing (Id(..))
import Browser
import Browser.Navigation as Nav
import Dict exposing (Dict)
import Element exposing (..)
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Http
import Maybe.Extra as Maybe
import RemoteData exposing (RemoteData)
import Url
import Url.Parser as Parser exposing ((</>), Parser, custom, fragment, map, oneOf, s, top)



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
    , score : Int
    , event : Event
    }


type alias Event =
    { id : Id
    , name : String
    }


queryOccasions : SelectionSet (List Occasion) RootQuery
queryOccasions =
    Query.occasions (occasionSelection |> hardcoded Nothing |> hardcoded Nothing)


queryOccasion : Id -> SelectionSet (Maybe Occasion) RootQuery
queryOccasion id =
    Query.occasion identity
        { id = id }
        (occasionSelection
            |> hardcoded Nothing
            |> with (Occasion.teams (teamSelection |> hardcoded Nothing))
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


occasionSelection =
    SelectionSet.succeed Occasion
        |> with Occasion.id
        |> with Occasion.name


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
        |> with
            (Competitor.event
                (SelectionSet.succeed Event
                    |> with Event.id
                    |> with Event.name
                )
            )


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
    { title = Maybe.unwrap "MarbleLympics" (\t -> t ++ " - " ++ "MarbleLympics") page.title
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


viewOccasion model =
    let
        success mo =
            Maybe.unwrap (text "Occasion not found") occasion mo

        occasion o =
            column []
                [ text o.name
                , Maybe.unwrap (text "no teams") (\teams -> column [] (List.map team teams)) o.teams
                ]

        team t =
            row [] [ text t.name ]
    in
    viewResponse model.occasion success


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
                            [ text c.event.name
                            , text (String.fromInt c.points)
                            , text (String.fromInt c.score)
                            ]
                    )
                    cs
                )
    in
    column []
        [ viewResponse model.marble
            (Maybe.unwrap (text "Marble does not exist") marble)
        ]


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
    ( { model | page = OccasionPage, occasion = RemoteData.Loading }
    , query (queryOccasion (Id occasion)) GotOccasion
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
