module Main exposing (Model, Msg(..), init, main, update, view)

import Api.Object.Team as Team
import Api.Query as Query
import Api.Scalar exposing (Id(..))
import Browser
import Dict exposing (Dict)
import Element exposing (..)
import Graphql.Http
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import RemoteData exposing (RemoteData)



---- MODEL ----


type alias Model =
    { route : Route, occasions : Dict String Occasion, response : RemoteData (Graphql.Http.Error Response) Response }


type alias Response =
    Maybe Team


type Route
    = EventRoute EventName
    | TeamRoute TeamName
    | MarbleRoute MarbleName
    | OccasionRoute String


type EventName
    = UnderwaterRace
    | FunnelRace
    | Balancing
    | GravitraxSlalom
    | FiveMeterSprint
    | RelayRun
    | BlockPushing
    | SummerBiathlon
    | HurdlesRace
    | HubelinoMaze
    | DirtRace


type TeamName
    = BallsOfChaos
    | Chocolatiers
    | CrazyCatsEyes
    | GreenDucks


type alias Occasion =
    { name : String
    , teams : List ( TeamName, List ( MarbleName, TeamRole ) )
    , events : List Event
    }


type MarbleName
    = Anarchy -- Balls Of Chaos
    | Tumult
    | Snarl
    | Clutter
    | Disarray


type TeamRole
    = Captain
    | Member
    | Reserve


type alias Date =
    { year : Int
    , month : Int
    , day : Int
    }


type alias Event =
    { event : EventName
    , date : Date
    , competitors : List ( MarbleName, TeamName )
    }


init : ( Model, Cmd Msg )
init =
    ( { route = OccasionRoute "ML2019"
      , response = RemoteData.Loading
      , occasions =
            Dict.fromList
                [ ( "ML2019"
                  , Occasion "MarbleLympics 2019"
                        [ ( BallsOfChaos
                          , [ ( Anarchy, Captain )
                            , ( Tumult, Member )
                            , ( Clutter, Member )
                            , ( Snarl, Member )
                            , ( Disarray, Reserve )
                            ]
                          )
                        ]
                        [ Event UnderwaterRace
                            (Date 2019 4 19)
                            [ ( Snarl, BallsOfChaos ) ]
                        ]
                  )
                ]
      }
    , makeRequest
    )


type alias Team =
    { name : String }


query id =
    Query.team { id = id } <| SelectionSet.map Team Team.name


makeRequest =
    Id "1"
        |> query
        |> Graphql.Http.queryRequest "http://localhost:4000/"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)



---- UPDATE ----


type Msg
    = GotResponse (RemoteData (Graphql.Http.Error Response) Response)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( { model | response = response }, Cmd.none )



---- VIEW ----


view model =
    -- layout [] <| viewRoute model.route model
    layout [] <|
        case model.response of
            RemoteData.Loading ->
                text "loading"

            RemoteData.Success team ->
                text "yay"

            RemoteData.Failure error ->
                text "error"

            _ ->
                text "error"


viewRoute route model =
    case route of
        OccasionRoute id ->
            case Dict.get id model.occasions of
                Just occasion ->
                    viewOccasion occasion

                Nothing ->
                    text ("occasion not found: " ++ id)

        _ ->
            text "not found"


viewOccasion occasion =
    column [] [ text occasion.name ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
