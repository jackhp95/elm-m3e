module View exposing (Freezable, View, freeze, freezableToHtml, htmlToFreezable, map)

{-| View module for elm-pages with frozen view support.

Migrated to the phantom substrate: `Markup.Node` → `HtmlIr.Node`.

@docs Freezable, View, freeze, freezableToHtml, htmlToFreezable, map

-}

import Html exposing (Html)
import HtmlIr.Node as Node exposing (Node)


{-| -}
type alias View msg =
    { title : String
    , body : List (Node msg)
    }


{-| -}
map : (msg1 -> msg2) -> View msg1 -> View msg2
map fn doc =
    { title = doc.title
    , body = List.map (Node.map fn) doc.body
    }


{-| The type of content that can be frozen. Must produce no messages (Never).
-}
type alias Freezable =
    Html Never


{-| Convert Freezable content to plain Html for server-side rendering.
-}
freezableToHtml : Freezable -> Html Never
freezableToHtml =
    identity


{-| Convert plain Html back to Freezable for client-side adoption.
-}
htmlToFreezable : Html Never -> Freezable
htmlToFreezable =
    identity


{-| Freeze a view so its content is rendered at build time.
-}
freeze : Freezable -> Html msg
freeze content =
    content
        |> freezableToHtml
        |> htmlToFreezable
        |> Html.map never
