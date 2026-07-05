module M3e.Cem.SegmentedButton exposing
    ( segmentedButton, disabled, hideSelectionIndicator, multi, name, onChange
    , onBeforeinput, onInput
    )

{-|
Middle layer for `<m3e-segmented-button>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SegmentedButton` module for everyday use.

@docs segmentedButton, disabled, hideSelectionIndicator, multi, name, onChange
@docs onBeforeinput, onInput
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.SegmentedButton
import M3e.Value


{-| A button that allows a user to select from a limited set of options.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the checked state of a segment changes.
- `beforeinput`: Dispatched before the checked state of a segment changes.
- `input`: Dispatched when the checked state of a segment changes.
-}
segmentedButton :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
segmentedButton attributes children =
    M3e.Cem.Html.SegmentedButton.segmentedButton
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SegmentedButton.disabled


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.SegmentedButton.hideSelectionIndicator


{-| Whether multiple options can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SegmentedButton.multi


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SegmentedButton.name


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.SegmentedButton.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.SegmentedButton.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.SegmentedButton.onInput
        (Json.Decode.succeed f_)