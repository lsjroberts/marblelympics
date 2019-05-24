module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Dict exposing (Dict)
import Element exposing (..)



---- MODEL ----


type alias Model =
    { route : Route, occasions : Dict String Occasion }


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
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view model =
    layout [] <| viewRoute model.route model


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
