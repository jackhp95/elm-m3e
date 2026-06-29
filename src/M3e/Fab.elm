module M3e.Fab exposing
    ( view
    , Option, ButtonType
    , variant, size, lowered, disabled, onClick, href, target, rel, download, label
    , formType, name, value
    )

{-| `<m3e-fab>` — a floating action button for the primary action on a screen.

Upstream mixins: `FormSubmitter` → `name` (attr), `value` (attr), `type`
(attr, `FormSubmitterType`, default `"button"`).

Spec (per docs/CONVENTIONS.md):

  - Required: { icon : String, ariaLabel : String }
    (icon = glyph name; ariaLabel = a11y label — FAB is icon-only with no
    visible text, so a required aria-label is mandatory)
  - Options: variant, size, lowered, disabled, onClick, href(+target/rel/download),
    label (extended-FAB visible text → sets `extended` property + slot "label"),
    formType, name, value
  - Slots: default slot ← `<m3e-icon>` for the glyph;
    "label" slot ← a span carrying the extended-FAB label text
  - Properties: disabled, lowered, extended (all via Node.property — introspectable/testable)
  - Attrs: variant/size via Cem.M3e.Fab.\* wrapped in Node.rawAttr
    (codegen name+enum safety; opaque, which is fine — no parent introspects them);
    name/value/type via Node.attribute (introspectable)
  - Events: click
  - A11y: aria-label = ariaLabel (required; m3e aria-hides its icon slot)
  - Tag: m3e-fab

@docs view
@docs Option, ButtonType
@docs variant, size, lowered, disabled, onClick, href, target, rel, download, label
@docs formType, name, value

-}

import Cem.M3e.Fab as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Attr as Attr
import M3e.Element as Element exposing (Element, Supported)
import M3e.Icon as Icon
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (AxisSupports, Value)


{-| FAB variant — seven M3 color roles (default `primaryContainer`), supplied
as shared [`M3e.Value`](M3e-Value) tokens.
-}
type alias Variants =
    Value
        { primary : Supported
        , primaryContainer : Supported
        , secondary : Supported
        , secondaryContainer : Supported
        , tertiary : Supported
        , tertiaryContainer : Supported
        , surface : Supported
        }


{-| FAB sizes (`small`, `medium`, `large`; default `medium`). The
supported-value row for the `size` axis.
-}
type alias Sizes =
    { small : Supported
    , medium : Supported
    , large : Supported
    }


type alias Config msg =
    { variant : Variants
    , size : AxisSupports Sizes
    , lowered : Bool
    , disabled : Bool
    , onClick : Maybe msg
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , label : Maybe String
    , formType : Maybe ButtonType
    , name : Maybe String
    , value : Maybe String
    }


{-| Form submission type for a FAB acting as a form submitter, supplied as
shared [`M3e.Value`](M3e-Value) tokens. Upstream: `FormSubmitter` mixin →
`type` attribute (`FormSubmitterType`), default [`button`](M3e-Value#button).
-}
type alias ButtonType =
    Value
        { submit : Supported
        , reset : Supported
        , button : Supported
        }


{-| Configuration option for `view`.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set the FAB variant (one of the seven M3 color roles). Default
[`M3e.Value.primaryContainer`](M3e-Value#primaryContainer).
-}
variant : Variants -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


{-| Set the FAB size (`small`, `medium`, `large`). Default `medium`.
Re-export of [`M3e.Attr.size`](M3e-Attr#size).
-}
size : Value Sizes -> Option msg
size =
    Attr.size


{-| Use the lowered (less-elevated) style. Default `False`.
-}
lowered : Bool -> Option msg
lowered b =
    Internal.option (\c -> { c | lowered = b })


{-| Disable the FAB. Default `False`.
-}
disabled : Bool -> Option msg
disabled =
    Attr.disabled


{-| Wire a click handler.
-}
onClick : msg -> Option msg
onClick =
    Attr.onClick


{-| Render the FAB as a link to the given URL.
-}
href : String -> Option msg
href =
    Attr.href


{-| Set the `target` for a link FAB (used with `href`).
-}
target : String -> Option msg
target =
    Attr.target


{-| Set the `rel` for a link FAB (used with `href`).
-}
rel : String -> Option msg
rel =
    Attr.rel


{-| Set the `download` for a link FAB (used with `href`).
-}
download : String -> Option msg
download =
    Attr.download


{-| Set the form submission type. Only meaningful when the FAB is inside a
`<form>` without `href`. Upstream: `FormSubmitter` mixin → `type` attribute.

  - [`submit`](M3e-Value#submit) — submits the form (`type="submit"`).
  - [`reset`](M3e-Value#reset) — resets the form (`type="reset"`).
  - [`button`](M3e-Value#button) — no default form action; use `onClick`.

-}
formType : ButtonType -> Option msg
formType v =
    Internal.option (\c -> { c | formType = Just v })


{-| Set the form field name (the `name` attribute on `<m3e-fab>`).
This identifies the FAB when its containing form is submitted.
Upstream: `FormSubmitter` mixin → `name` attribute.
-}
name : String -> Option msg
name v =
    Internal.option (\c -> { c | name = Just v })


{-| Set the submitted value (the `value` attribute on `<m3e-fab>`).
Paired with `name` on form submission. Upstream: `FormSubmitter` mixin → `value` attribute.
-}
value : String -> Option msg
value v =
    Internal.option (\c -> { c | value = Just v })


{-| Visible label for an extended FAB. Setting this option also sets the
`extended` property on the element so it expands to show the label.
-}
label : String -> Option msg
label v =
    Internal.option (\c -> { c | label = Just v })


{-| Render the FAB with its required `icon` and `ariaLabel`.
-}
view : { icon : String, ariaLabel : String } -> List (Option msg) -> Element { s | fab : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts
                { variant = Value.primaryContainer
                , size = Value.emptyAxis
                , lowered = False
                , disabled = False
                , onClick = Nothing
                , href = Nothing
                , target = Nothing
                , rel = Nothing
                , download = Nothing
                , label = Nothing
                , formType = Nothing
                , name = Nothing
                , value = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-fab"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.ariaLabel)
                , Just (Node.attribute "variant" (Value.toString c.variant))
                , Just (Node.attribute "size" (Value.axisStringOr Value.medium c.size))
                , Just (Node.property "lowered" (Encode.bool c.lowered))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Just (Node.property "extended" (Encode.bool (c.label /= Nothing)))
                , Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                , Maybe.map (\v -> Node.rawAttr (Cem.href v)) c.href
                , Maybe.map (\v -> Node.rawAttr (Cem.target v)) c.target
                , Maybe.map (\v -> Node.rawAttr (Cem.rel v)) c.rel
                , Maybe.map (\v -> Node.rawAttr (Cem.download v)) c.download
                , Maybe.map (\t -> Node.attribute "type" (Value.toString t)) c.formType
                , Maybe.map (\v -> Node.attribute "name" v) c.name
                , Maybe.map (\v -> Node.attribute "value" v) c.value
                ]
            )
            (List.filterMap identity
                [ Just (Element.toNode (Icon.view { name = req.icon } []))
                , Maybe.map (\lbl -> Node.withSlot "label" (Node.element "span" [] [ Node.text lbl ])) c.label
                ]
            )
        )
