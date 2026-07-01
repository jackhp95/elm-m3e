module Route.Styles.Shape exposing (ActionData, Data, Model, Msg, route)

{-| STUB (migration): uses M3e.Shape/CemShape whose new API differs; original view is in
git history, pending a design call + the ornith pass. Route wiring preserved.
-}

import BackendTask exposing (BackendTask)
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
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildNoState { view = view }


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Shape · elm-m3e"
    , body =
        [ Node.text "The Shape page is being migrated to the new Vocab API; original view in git history." ]
    }
