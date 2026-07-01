module M3e.Cem.Chip exposing (chip, value, variant)

{-| 
@docs chip, value, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Chip
import M3e.Value


{-| A non-interactive chip used to convey small pieces of information.

**Slots:**
- `icon`: Renders an icon before the chip's label.
- `trailing-icon`: Renders an icon after the chip's label.
-}
chip :
    List (M3e.Cem.Attr.Attr { value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
chip attributes children =
    M3e.Cem.Html.Chip.chip
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| A string representing the value of the chip. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Chip.value


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Chip.variant (M3e.Value.toString v_)