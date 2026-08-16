module M3e.Component.Accordion exposing
    ( component
    , Is, Attrs, Content, ChildAdmittedBy
    , multi
    , child
    )

{-| The `m3e-accordion` component — strict per-component surface.

Combines multiple expansion panels in to an accordion.

@docs component
@docs Is, Attrs, Content, ChildAdmittedBy
@docs multi
@docs child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Html as H
import M3e.Internal.Types.Accordion
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-accordion` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Accordion.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Accordion.Attrs


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.Accordion.Content


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Accordion.ChildAdmittedBy childAdm


{-| Required-content (and action) constructor — omissions are unwritable.
-}
component :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
component required_ attrs children =
    H.accordion attrs (required_.content :: children)


{-| See `M3e.Attributes.multi`.
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi =
    A.multi


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)
