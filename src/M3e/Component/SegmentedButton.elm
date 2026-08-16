module M3e.Component.SegmentedButton exposing
    ( component
    , Is, Attrs, Content, ChildAdmittedBy
    , disabled, hideSelectionIndicator, multi, name, onChange, onBeforeinput, onInput
    , child
    )

{-| The `m3e-segmented-button` component — strict per-component surface.

A button that allows a user to select from a limited set of options.

@docs component
@docs Is, Attrs, Content, ChildAdmittedBy
@docs disabled, hideSelectionIndicator, multi, name, onChange, onBeforeinput, onInput
@docs child


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.Component.SegmentedButton.el
    { content = M3e.Component.ButtonSegment.el [] [ TypedHtml.text "Day" ] }
    []
    [ M3e.Component.ButtonSegment.el [] [ TypedHtml.text "Week" ]
    , M3e.Component.ButtonSegment.el [] [ TypedHtml.text "Month" ]
    ]
```

<!-- elm-cem:docmeta category=Actions -->

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import Json.Encode
import M3e.Attributes as A
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.SegmentedButton
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-segmented-button` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.SegmentedButton.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.SegmentedButton.Attrs


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.SegmentedButton.Content


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.SegmentedButton.ChildAdmittedBy childAdm


{-| Required-content (and action) constructor — omissions are unwritable.
-}
component :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
component required_ attrs children =
    H.segmentedButton attrs (required_.content :: children)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.hideSelectionIndicator`.
-}
hideSelectionIndicator : Bool -> Attr { c | hideSelectionIndicator : Supported } msg
hideSelectionIndicator =
    A.hideSelectionIndicator


{-| See `M3e.Attributes.multi`.
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi =
    A.multi


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" value_


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| See `M3e.Events.onBeforeinput`.
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Ev.onBeforeinput


{-| See `M3e.Events.onInput`.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Ev.onInput


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)
