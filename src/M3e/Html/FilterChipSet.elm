module M3e.Html.FilterChipSet exposing
    ( filterChipSet, disabled, hideSelectionIndicator, multi, name, vertical
    , onChange, onBeforeinput, onInput
    )

{-| Middle layer for `<m3e-filter-chip-set>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FilterChipSet` module for everyday use.

@docs filterChipSet, disabled, hideSelectionIndicator, multi, name, vertical
@docs onChange, onBeforeinput, onInput

-}

import Html
import Json.Decode
import M3e.Raw.FilterChipSet
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , hideSelectionIndicator : M3e.Token.Supported
            , multi : M3e.Token.Supported
            , name : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
filterChipSet attributes children =
    M3e.Raw.FilterChipSet.filterChipSet
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.FilterChipSet.disabled


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
hideSelectionIndicator =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.FilterChipSet.hideSelectionIndicator


{-| Whether multiple chips can be selected. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    Markup.Html.Attr.Internal.attribute M3e.Raw.FilterChipSet.multi


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.FilterChipSet.name


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Markup.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    Markup.Html.Attr.Internal.attribute M3e.Raw.FilterChipSet.vertical


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.FilterChipSet.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.FilterChipSet.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.FilterChipSet.onInput
        (Json.Decode.succeed f_)
