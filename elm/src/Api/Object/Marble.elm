-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.Marble exposing (competitions, id, name, team)

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


competitions : SelectionSet decodesTo Api.Object.Competitor -> SelectionSet (Maybe (List decodesTo)) Api.Object.Marble
competitions object_ =
    Object.selectionForCompositeField "competitions" [] object_ (identity >> Decode.list >> Decode.nullable)


id : SelectionSet Api.ScalarCodecs.Id Api.Object.Marble
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecId |> .decoder)


name : SelectionSet String Api.Object.Marble
name =
    Object.selectionForField "String" "name" [] Decode.string


team : SelectionSet decodesTo Api.Object.Team -> SelectionSet decodesTo Api.Object.Marble
team object_ =
    Object.selectionForCompositeField "team" [] object_ identity
