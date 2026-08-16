module M3e.Component.MenuTrigger exposing
    ( component
    , Is, Attrs, ChildAdmittedBy
    , child
    )

{-| The `m3e-menu-trigger` component — strict per-component surface.

An element, nested within a clickable element, used to open a menu.

@docs component
@docs Is, Attrs, ChildAdmittedBy
@docs child


## Examples


### Examples

<!-- elm-cem:example title="Opening a menu by id (required `for`)" -->
```elm
M3e.Component.MenuTrigger.el { for = "main-menu" } [] [ TypedHtml.text "Open menu" ]
```

<!-- elm-cem:docmeta category=Navigation -->

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Html as H
import M3e.Internal.Types.MenuTrigger
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-menu-trigger` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.MenuTrigger.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.MenuTrigger.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.MenuTrigger.ChildAdmittedBy childAdm


{-| Required-content (and action) constructor — omissions are unwritable.
-}
component :
    { for : String }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
component required_ attrs children =
    H.menuTrigger (Ir.attribute "for" required_.for :: attrs) children


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)
