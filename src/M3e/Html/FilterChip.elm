module M3e.Html.FilterChip exposing
    ( filterChip, disabled, disabledInteractive, selected, value, variant
    , onBeforeinput, onInput, onChange, onClick
    )

{-| Middle layer for `<m3e-filter-chip>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FilterChip` module for everyday use.

@docs filterChip, disabled, disabledInteractive, selected, value, variant
@docs onBeforeinput, onInput, onChange, onClick

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.FilterChip
import M3e.Token


{-| A chip users interact with to select/deselect options.

**Component Info:**

  - **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**

  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.
  - `change`: Dispatched when the selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the chip's label.
  - `trailing-icon`: Renders an icon after the chip's label.

-}
filterChip :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
filterChip attributes children =
    M3e.Raw.FilterChip.filterChip
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FilterChip.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    -> M3e.Html.Attr.Attr { c | disabledInteractive : M3e.Token.Supported } msg
disabledInteractive =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FilterChip.disabledInteractive


{-| A value indicating whether the element is selected. (default: `false`)
-}
selected : Bool -> M3e.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FilterChip.selected


{-| A string representing the value of the chip.
-}
value : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FilterChip.value


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FilterChip.variant
        (M3e.Token.toString v_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FilterChip.onBeforeinput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FilterChip.onInput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FilterChip.onChange
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FilterChip.onClick
        (Json.Decode.succeed f_)
