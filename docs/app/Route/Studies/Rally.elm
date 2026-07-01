module Route.Studies.Rally exposing (ActionData, Data, Model, Msg, route)

{-| STUB (migration): the original rich view is preserved in git history and will be
restored by the ornith pass (docs/ORNITH\_MIGRATION\_PLAN.md). Route wiring + exposed
signatures are unchanged so the app compiles.
-}

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import Head
import M3e.Node as Node
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( {}, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ _ model =
    ( model, Effect.none )


subscriptions : RouteParams -> UrlPath.UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ _ =
    { title = "Rally · elm-m3e"
    , body =
        [ Node.text "Rally — being migrated to the new Vocab API; the original view is preserved in git history." ]
    }
