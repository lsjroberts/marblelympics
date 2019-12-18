-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.OccasionTeamResult exposing (cumulativePoints, cumulativeRank, event, occasionEvent, points, rank)

import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.ScalarCodecs
import Api.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


cumulativePoints : SelectionSet Int Api.Object.OccasionTeamResult
cumulativePoints =
    Object.selectionForField "Int" "cumulativePoints" [] Decode.int


cumulativeRank : SelectionSet Int Api.Object.OccasionTeamResult
cumulativeRank =
    Object.selectionForField "Int" "cumulativeRank" [] Decode.int


event : SelectionSet decodesTo Api.Object.Event -> SelectionSet decodesTo Api.Object.OccasionTeamResult
event object_ =
    Object.selectionForCompositeField "event" [] object_ identity


occasionEvent : SelectionSet decodesTo Api.Object.OccasionEvent -> SelectionSet decodesTo Api.Object.OccasionTeamResult
occasionEvent object_ =
    Object.selectionForCompositeField "occasionEvent" [] object_ identity


points : SelectionSet Int Api.Object.OccasionTeamResult
points =
    Object.selectionForField "Int" "points" [] Decode.int


rank : SelectionSet Int Api.Object.OccasionTeamResult
rank =
    Object.selectionForField "Int" "rank" [] Decode.int