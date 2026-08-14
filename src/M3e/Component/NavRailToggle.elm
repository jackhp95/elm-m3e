module M3e.Component.NavRailToggle exposing
    ( el
    , Is, Attrs, ChildAdmittedBy
    )

{-| The `m3e-nav-rail-toggle` component — strict per-component surface.

An element, nested within a clickable element, used to toggle the expanded state of a navigation rail.

@docs el
@docs Is, Attrs, ChildAdmittedBy

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Html as H
import M3e.Internal.Types.NavRailToggle
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-nav-rail-toggle` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.NavRailToggle.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.NavRailToggle.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.NavRailToggle.ChildAdmittedBy childAdm


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { for : String }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    H.navRailToggle (Ir.attribute "for" required_.for :: attrs) children
