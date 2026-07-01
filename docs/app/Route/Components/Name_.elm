module Route.Components.Name_ exposing (ActionData, Data, Model, Msg, route)

{-| STUB (migration): the per-component showcase view is preserved in git history and
will be restored by the ornith pass. Data pipeline reduced to a stub so the app compiles.
-}

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import M3e.Node as Node
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    { name : String }


type alias Data =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.preRender { head = head, pages = pages, data = data }
        |> RouteBuilder.buildNoState { view = view }


pages : BackendTask FatalError (List RouteParams)
pages =
    BackendTask.succeed []


data : RouteParams -> BackendTask FatalError Data
data _ =
    BackendTask.succeed {}


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Component reference · elm-m3e"
    , body =
        [ Node.text "The per-component showcase is being migrated to the new Vocab API; original view in git history." ]
    }
