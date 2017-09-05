module Router
    exposing
        ( route
        , routeMsg
        , routeInit
        , reverse
        , reverseHref
        )

import Html
import Html.Attributes
import Navigation
import UrlParser exposing (Parser, (</>), s, int, string, map, oneOf, parseHash)


--

import Model
import Model.PageState exposing (Page(..))
import Msg
import Msg.PageState
import Update.PageState


route : Parser (Page -> a) a
route =
    oneOf
        [ map HomeP (s "home")
        , map AboutP (s "about")
        ]


routeMsg : Navigation.Location -> Msg.PageState.Msg
routeMsg loc =
    parseHash route loc
        |> Maybe.withDefault HomeP
        |> Msg.PageState.Navigate


routeInit : Navigation.Location -> Model.Model -> ( Model.Model, Cmd Msg.Msg )
routeInit loc model =
    loc
        |> routeMsg
        |> flip Update.PageState.update model


reverse : Page -> String
reverse page =
    ((++) "#") <|
        case page of
            HomeP ->
                "home"

            AboutP ->
                "about"


reverseHref : Page -> Html.Attribute Msg.PageState.Msg
reverseHref =
    Html.Attributes.href << reverse
