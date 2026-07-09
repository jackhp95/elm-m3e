module M3e.Cem.FilterChipSet exposing
    ( filterChipSet, disabled, hideSelectionIndicator, multi, name, vertical
    , onChange, onBeforeinput, onInput
    )

{-|
Middle layer for `<m3e-filter-chip-set>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FilterChipSet` module for everyday use.

@docs filterChipSet, disabled, hideSelectionIndicator, multi, name, vertical
@docs onChange, onBeforeinput, onInput
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.FilterChipSet
import M3e.Value


{-| A container that organizes filter chips into a cohesive group, enabling selection and
deselection of values used to refine content or trigger contextual behavior.

**Component Info:**
- **Extends:** `M3eChipSetElement` from `/src/chips/ChipSetElement`

**Events:**
- `change`: Dispatched when the selected state of a chip changes.
- `beforeinput`: Dispatched before the selected state of a chip changes.
- `input`: Dispatched when the selected state of a chip changes.
-}
filterChipSet :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
filterChipSet attributes children =
    M3e.Cem.Html.FilterChipSet.filterChipSet
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.FilterChipSet.disabled


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.FilterChipSet.hideSelectionIndicator


{-| Whether multiple chips can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.FilterChipSet.multi


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.FilterChipSet.name


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.FilterChipSet.vertical


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.FilterChipSet.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.FilterChipSet.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.FilterChipSet.onInput
        (Json.Decode.succeed f_)