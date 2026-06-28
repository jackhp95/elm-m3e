module M3e exposing
    ( Element, Supported, Node
    , text, html, toNode
    , disabled, onClick, href, target, rel, download, id
    , buttonElevated, buttonFilled, buttonTonal, buttonOutlined, buttonText
    , chip, chipAssist, chipSuggestion, chipFilter, chipInput
    , card, cardElevated, cardFilled, cardOutlined
    )

{-| Top-level facade for the M3e component library, so the common case is a
single `import M3e exposing (..)`.

This module is a thin re-binding layer — it adds no behaviour. The component
modules (`M3e.Button`, `M3e.Chip`, …) remain the documented source of truth; this
module just collects the most-reached-for names so callers need not import each
component individually.

**Slice status:** Button, Chip, and Card entry points only. Remaining components
are still reached via their own modules until the full facade lands.

Per-variant entry points bake the variant in for IDE discovery and brevity:

    import M3e exposing (..)

    M3e.buttonFilled { label = "Save" } [ onClick Save, disabled busy ]
    M3e.chipAssist { label = "Add", onClick = Add } []
    M3e.cardElevated [] |> toNode

Component-specific options that take shared [`M3e.Value`](M3e-Value) tokens
(e.g. `Button.size Value.large`) still come from the component module; only the
universally-shared attributes are re-exposed here.


# Core vocabulary

@docs Element, Supported, Node
@docs text, html, toNode


# Shared attributes

@docs disabled, onClick, href, target, rel, download, id


# Buttons

@docs buttonElevated, buttonFilled, buttonTonal, buttonOutlined, buttonText


# Chips

@docs chip, chipAssist, chipSuggestion, chipFilter, chipInput


# Cards

@docs card, cardElevated, cardFilled, cardOutlined

-}

import Html exposing (Html)
import M3e.Attr as Attr
import M3e.Button as Button
import M3e.Card as Card
import M3e.Chip as Chip
import M3e.Element as Element
import M3e.Internal exposing (Option)
import M3e.Node as Node
import M3e.Value as Value



-- CORE VOCABULARY --------------------------------------------------------


{-| The introspectable IR element. Re-export of [`M3e.Element.Element`](M3e-Element#Element).
-}
type alias Element supported msg =
    Element.Element supported msg


{-| Marker for a slot/kind a component supports. Re-export of
[`M3e.Element.Supported`](M3e-Element#Supported).
-}
type alias Supported =
    Element.Supported


{-| The raw IR node. Re-export of [`M3e.Node.Node`](M3e-Node#Node).
-}
type alias Node msg =
    Node.Node msg


{-| A bit of text as a slottable element. Re-export of
[`M3e.Element.text`](M3e-Element#text).
-}
text : String -> Element { s | element : Supported } msg
text =
    Element.text


{-| Lift raw `Html` into a default-slot-region element. Re-export of
[`M3e.Element.html`](M3e-Element#html).
-}
html : Html msg -> Element { s | html : Supported } msg
html =
    Element.html


{-| Unwrap an element to its underlying `Node` for rendering. Re-export of
[`M3e.Element.toNode`](M3e-Element#toNode).
-}
toNode : Element supported msg -> Node msg
toNode =
    Element.toNode



-- SHARED ATTRIBUTES ------------------------------------------------------


{-| Disable a component. Re-export of [`M3e.Attr.disabled`](M3e-Attr#disabled).
-}
disabled : Bool -> Option { c | disabled : Bool } msg
disabled =
    Attr.disabled


{-| Wire a click handler. Re-export of [`M3e.Attr.onClick`](M3e-Attr#onClick).
-}
onClick : msg -> Option { c | onClick : Maybe msg } msg
onClick =
    Attr.onClick


{-| Render as a link. Re-export of [`M3e.Attr.href`](M3e-Attr#href).
-}
href : String -> Option { c | href : Maybe String } msg
href =
    Attr.href


{-| Set the link target. Re-export of [`M3e.Attr.target`](M3e-Attr#target).
-}
target : String -> Option { c | target : Maybe String } msg
target =
    Attr.target


{-| Set the link rel. Re-export of [`M3e.Attr.rel`](M3e-Attr#rel).
-}
rel : String -> Option { c | rel : Maybe String } msg
rel =
    Attr.rel


{-| Request the link target be downloaded. Re-export of
[`M3e.Attr.download`](M3e-Attr#download).
-}
download : String -> Option { c | download : Maybe String } msg
download =
    Attr.download


{-| Set the element id. Re-export of [`M3e.Attr.id`](M3e-Attr#id).
-}
id : String -> Option { c | id : Maybe String } msg
id =
    Attr.id



-- BUTTON -----------------------------------------------------------------


{-| An elevated button. [`M3e.Button.view`](M3e-Button#view) with
`variant = Value.elevated`.
-}
buttonElevated : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonElevated req =
    Button.view { label = req.label, variant = Value.elevated }


{-| A filled button. [`M3e.Button.view`](M3e-Button#view) with
`variant = Value.filled`.
-}
buttonFilled : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonFilled req =
    Button.view { label = req.label, variant = Value.filled }


{-| A tonal button. [`M3e.Button.view`](M3e-Button#view) with
`variant = Value.tonal`.
-}
buttonTonal : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonTonal req =
    Button.view { label = req.label, variant = Value.tonal }


{-| An outlined button. [`M3e.Button.view`](M3e-Button#view) with
`variant = Value.outlined`.
-}
buttonOutlined : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonOutlined req =
    Button.view { label = req.label, variant = Value.outlined }


{-| A text button. [`M3e.Button.view`](M3e-Button#view) with
`variant = Value.textVariant`.
-}
buttonText : { label : String } -> List (Button.Option msg) -> Element { s | button : Supported } msg
buttonText req =
    Button.view { label = req.label, variant = Value.textVariant }



-- CHIP -------------------------------------------------------------------


{-| A display chip. Re-export of [`M3e.Chip.view`](M3e-Chip#view).
-}
chip : { label : String } -> List (Chip.ViewOption msg) -> Element { s | chip : Supported } msg
chip =
    Chip.view


{-| An assist chip. Re-export of [`M3e.Chip.assist`](M3e-Chip#assist).
-}
chipAssist : { label : String, onClick : msg } -> List (Chip.Option msg) -> Element { s | chip : Supported } msg
chipAssist =
    Chip.assist


{-| A suggestion chip. Re-export of [`M3e.Chip.suggestion`](M3e-Chip#suggestion).
-}
chipSuggestion : { label : String, onClick : msg } -> List (Chip.Option msg) -> Element { s | chip : Supported } msg
chipSuggestion =
    Chip.suggestion


{-| A filter chip. Re-export of [`M3e.Chip.filter`](M3e-Chip#filter).
-}
chipFilter : { label : String, onToggle : msg } -> List (Chip.Option msg) -> Element { s | chip : Supported } msg
chipFilter =
    Chip.filter


{-| An input chip. Re-export of [`M3e.Chip.input`](M3e-Chip#input).
-}
chipInput : { label : String, onRemove : msg } -> List (Chip.Option msg) -> Element { s | chip : Supported } msg
chipInput =
    Chip.input



-- CARD -------------------------------------------------------------------


{-| A card with no explicit variant. Re-export of [`M3e.Card.view`](M3e-Card#view).
-}
card : List (Card.Option msg) -> Element { s | card : Supported } msg
card =
    Card.view


{-| An elevated card. [`M3e.Card.view`](M3e-Card#view) with the
`variant = Value.elevated` option prepended.
-}
cardElevated : List (Card.Option msg) -> Element { s | card : Supported } msg
cardElevated opts =
    Card.view (Card.variant Value.elevated :: opts)


{-| A filled card. [`M3e.Card.view`](M3e-Card#view) with the
`variant = Value.filled` option prepended.
-}
cardFilled : List (Card.Option msg) -> Element { s | card : Supported } msg
cardFilled opts =
    Card.view (Card.variant Value.filled :: opts)


{-| An outlined card. [`M3e.Card.view`](M3e-Card#view) with the
`variant = Value.outlined` option prepended.
-}
cardOutlined : List (Card.Option msg) -> Element { s | card : Supported } msg
cardOutlined opts =
    Card.view (Card.variant Value.outlined :: opts)
