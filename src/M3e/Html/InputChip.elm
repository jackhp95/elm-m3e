module M3e.Html.InputChip exposing
    ( inputChip, disabled, disabledInteractive, removable, removeLabel, value
    , variant, onRemove, onClick
    )

{-| Middle layer for `<m3e-input-chip>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.InputChip` module for everyday use.

@docs inputChip, disabled, disabledInteractive, removable, removeLabel, value
@docs variant, onRemove, onClick

-}

import Html
import Json.Decode
import M3e.Raw.InputChip
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A chip which represents a discrete piece of information entered by a user.

**Component Info:**

  - **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**

  - `remove`: Dispatched when the remove button is clicked or DELETE or BACKSPACE key is pressed.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `avatar`: Renders an avatar before the chip's label.
  - `icon`: Renders an icon before the chip's label.
  - `remove-icon`: Renders the icon for the button used to remove the chip.
  - `trailing-icon`: Renders an icon after the chip's label.

-}
inputChip :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , removable : M3e.Token.Supported
            , removeLabel : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onRemove : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
inputChip attributes children =
    M3e.Raw.InputChip.inputChip
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.InputChip.disabled


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | disabledInteractive : M3e.Token.Supported
            }
            msg
disabledInteractive =
    Markup.Html.Attr.Internal.attribute M3e.Raw.InputChip.disabledInteractive


{-| Whether the chip is removable. (default: `false`)
-}
removable : Bool -> Markup.Html.Attr.Attr { c | removable : M3e.Token.Supported } msg
removable =
    Markup.Html.Attr.Internal.attribute M3e.Raw.InputChip.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
removeLabel :
    String
    -> Markup.Html.Attr.Attr { c | removeLabel : M3e.Token.Supported } msg
removeLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.InputChip.removeLabel


{-| A string representing the value of the chip.
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    Markup.Html.Attr.Internal.attribute M3e.Raw.InputChip.value


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.InputChip.variant
        (M3e.Token.toString v_)


{-| Listen for `remove` events.
-}
onRemove : msg -> Markup.Html.Attr.Attr { c | onRemove : M3e.Token.Supported } msg
onRemove f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.InputChip.onRemove
        (Json.Decode.succeed f_)


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.InputChip.onClick
        (Json.Decode.succeed f_)
