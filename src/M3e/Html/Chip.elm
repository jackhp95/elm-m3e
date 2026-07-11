module M3e.Html.Chip exposing (chip, value, variant)

{-| Middle layer for `<m3e-chip>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Chip` module for everyday use.

@docs chip, value, variant

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Chip
import M3e.Token


{-| A non-interactive chip used to convey small pieces of information.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `icon`: Renders an icon before the chip's label.
  - `trailing-icon`: Renders an icon after the chip's label.

-}
chip :
    List
        (M3e.Html.Attr.Attr
            { value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
chip attributes children =
    M3e.Raw.Chip.chip (List.map M3e.Html.Attr.toAttribute attributes) children


{-| A string representing the value of the chip.
-}
value : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Chip.value


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
        M3e.Raw.Chip.variant
        (M3e.Token.toString v_)
