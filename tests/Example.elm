module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, list, int, string)
import Test exposing (..)


--

import Model.PageState
import Msg.PageState
import Router


suite : Test
suite =
    describe "Router" <|
        let
            location =
                { href = ""
                , host = ""
                , hostname = ""
                , protocol = ""
                , origin = ""
                , port_ = ""
                , pathname = ""
                , search = ""
                , hash = ""
                , username = ""
                , password = ""
                }
        in
            [ describe "routeMsg"
                [ test "It uses the hash" <|
                    \_ ->
                        let
                            l =
                                { location | hash = "home" }
                        in
                            Expect.equal
                                (Router.routeMsg l)
                                (Msg.PageState.Navigate Model.PageState.HomeP)
                ]
            ]
