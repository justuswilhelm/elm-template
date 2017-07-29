module View exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (..)
import View.Index


view : Model -> Html Msg
view =
    View.Index.view
