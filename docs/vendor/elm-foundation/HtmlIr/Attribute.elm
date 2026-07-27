module HtmlIr.Attribute exposing
    ( Attr
    , map, toHtmlAttribute
    )

{-| The phantom-typed attribute shared by every library on this substrate. An
`Attr capability msg` is an `Html.Attribute` carrying a phantom row of the
element capabilities that admit it; producers keep the row open
(`{ c | href : Supported }`) and each element constructor closes it, so the
compiler rejects an attribute on an element that does not admit it — including
events (`onClick` on a non-interactive element is a type error).

This module is the safe surface: minting an `Attr` — which asserts its row —
happens only in brand setters or the fenced forge in
[`HtmlIr.Internal`](HtmlIr-Internal).

@docs Attr
@docs map, toHtmlAttribute

-}

import Html
import HtmlIr.Internal as I


{-| The opaque phantom-typed attribute.
-}
type alias Attr capability msg =
    I.Attr capability msg


{-| Map the message type. Capability row preserved.
-}
map : (a -> b) -> Attr capability a -> Attr capability b
map =
    I.mapAttribute


{-| Unwrap to the underlying `Html.Attribute` — the safe out-bound direction.
-}
toHtmlAttribute : Attr capability msg -> Html.Attribute msg
toHtmlAttribute =
    I.toHtmlAttribute
