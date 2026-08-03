module TypedHtml.Unsafe.Attributes exposing
    ( fromHtmlAttribute
    , recastAttr, recastAttrAll
    )

{-| The attribute-side twins of [`TypedHtml.Unsafe`](TypedHtml-Unsafe): lift a raw
`Html.Attribute`, or re-kind an existing `Attr` — both with a FREE capability row,
so the compiler checks nothing about which element the attribute may land on. For
incremental migration and slot-fit only; every use site is a grep target and a
lint finding.

@docs fromHtmlAttribute
@docs recastAttr, recastAttrAll

-}

import Html
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Internal as Ir


{-| Lift a raw `Html.Attribute` into an `Attr` with a FREE capability row. Loud on purpose.
-}
fromHtmlAttribute : Html.Attribute msg -> Attr capability msg
fromHtmlAttribute =
    Ir.fromHtmlAttribute


{-| Re-kind an `Attr` to a FREE capability row so it fits any element — the attribute-side recast. Loud on purpose.
-}
recastAttr : Attr aCapability msg -> Attr bCapability msg
recastAttr attr =
    Ir.recast attr


{-| `recastAttr` mapped over a list of attributes.
-}
recastAttrAll : List (Attr aCapability msg) -> List (Attr bCapability msg)
recastAttrAll =
    List.map recastAttr
