module M3e.Unsafe exposing
    ( fromHtml
    , coerce, coerceAll
    )

{-| THE loud legacy-interop escapes: wrap raw `Html` as an `Element`, or
re-kind an existing `Element` — both with FREE phantom rows, so the
compiler checks nothing about the result. For incremental migration and
slot-fit only; every use site is a grep target and a lint finding.

@docs fromHtml
@docs coerce, coerceAll

-}

import Html exposing (Html)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir


{-| Wrap raw `Html` with FREE rows. Loud on purpose.
-}
fromHtml : Html msg -> Element accepts admittedBy msg
fromHtml h =
    Ir.fromNode (Ir.fromHtml h)


{-| Re-kind an `Element` to FREE rows so it fits any slot — the blessed form of the hand-forged `Ir.fromNode << HtmlIr.Element.toNode` recast. Loud on purpose.
-}
coerce : Element aAccepts aAdmittedBy msg -> Element bAccepts bAdmittedBy msg
coerce element =
    Ir.fromNode (HtmlIr.Element.toNode element)


{-| `coerce` mapped over a list of elements.
-}
coerceAll : List (Element aAccepts aAdmittedBy msg) -> List (Element bAccepts bAdmittedBy msg)
coerceAll =
    List.map coerce
