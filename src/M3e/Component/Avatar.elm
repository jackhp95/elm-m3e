module M3e.Component.Avatar exposing
    ( component
    , Is, Attrs, ChildAdmittedBy
    , child
    )

{-| The `m3e-avatar` component — strict per-component surface.

An image, icon or textual initials representing a user or other identity.

@docs component
@docs Is, Attrs, ChildAdmittedBy
@docs child


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.Component.Avatar.el [] [ TypedHtml.text "JP" ]
```

<!-- elm-cem:docmeta category=Layout & style -->

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Html as H
import M3e.Internal.Types.Avatar
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-avatar` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Avatar.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Avatar.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Avatar.ChildAdmittedBy childAdm


{-| Standard constructor: `[attributes] [children]`. The default slot is
kind-permissive (`any`): children of any kind compose, but each child's OWN
admittedBy must still admit this context — a restricted-parent element is
rejected here at compile time.
-}
component :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
component =
    H.avatar


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)
