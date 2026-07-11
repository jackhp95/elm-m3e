module M3e.Html.ExpansionHeader exposing (expansionHeader, hideToggle, toggleDirection, togglePosition, disabled, onClick)

{-| Middle layer for `<m3e-expansion-header>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ExpansionHeader` module for everyday use.

@docs expansionHeader, hideToggle, toggleDirection, togglePosition, disabled, onClick

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.ExpansionHeader
import M3e.Token


{-| A button used to toggle the expanded state of an expansion panel.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `toggle-icon`: Renders the icon of the expansion toggle.

-}
expansionHeader :
    List
        (M3e.Html.Attr.Attr
            { hideToggle : M3e.Token.Supported
            , toggleDirection : M3e.Token.Supported
            , togglePosition : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
expansionHeader attributes children =
    M3e.Raw.ExpansionHeader.expansionHeader
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> M3e.Html.Attr.Attr { c | hideToggle : M3e.Token.Supported } msg
hideToggle =
    M3e.Html.Attr.Internal.attribute M3e.Raw.ExpansionHeader.hideToggle


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirection v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ExpansionHeader.toggleDirection
        (M3e.Token.toString v_)


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePosition v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ExpansionHeader.togglePosition
        (M3e.Token.toString v_)


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.ExpansionHeader.disabled


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ExpansionHeader.onClick
        (Json.Decode.succeed f_)
