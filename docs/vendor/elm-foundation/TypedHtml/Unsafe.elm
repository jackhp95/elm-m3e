module TypedHtml.Unsafe exposing (fromHtml)

{-| THE loud legacy-interop escape: wrap raw `Html` as an `Element` with
FREE phantom rows — the compiler checks nothing about it. For incremental
migration only; every use site is a grep target and a lint finding.

@docs fromHtml

-}

import Html exposing (Html)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir


{-| Wrap raw `Html` with FREE rows. Loud on purpose.
-}
fromHtml : Html msg -> Element accepts admittedBy msg
fromHtml h =
    Ir.fromNode (Ir.fromHtml h)
