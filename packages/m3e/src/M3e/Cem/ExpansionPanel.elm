module M3e.Cem.ExpansionPanel exposing
    ( expansionPanel, disabled, hideToggle, open, toggleDirection, togglePosition
    , onOpening, onOpened, onClosing, onClosed
    )

{-|
Middle layer for `<m3e-expansion-panel>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ExpansionPanel` module for everyday use.

@docs expansionPanel, disabled, hideToggle, open, toggleDirection, togglePosition
@docs onOpening, onOpened, onClosing, onClosed
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.ExpansionPanel
import M3e.Value


{-| An expandable details-summary view.

**Events:**
- `opening`: Dispatched when the expansion panel begins to open.
- `opened`: Dispatched when the expansion panel has opened.
- `closing`: Dispatched when the expansion panel begins to close.
- `closed`: Dispatched when the expansion panel has closed.

**Slots:**
- `actions`: Renders the actions bar of the panel.
- `header`: Renders the header content.
- `toggle-icon`: Renders the expansion toggle icon.
-}
expansionPanel :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideToggle : M3e.Value.Supported
    , open : M3e.Value.Supported
    , toggleDirection : M3e.Value.Supported
    , togglePosition : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
expansionPanel attributes children =
    M3e.Cem.Html.ExpansionPanel.expansionPanel
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ExpansionPanel.disabled


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool -> M3e.Cem.Attr.Attr { c | hideToggle : M3e.Value.Supported } msg
hideToggle =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ExpansionPanel.hideToggle


{-| Whether the panel is expanded. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ExpansionPanel.open


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | toggleDirection : M3e.Value.Supported } msg
toggleDirection v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpansionPanel.toggleDirection
        (M3e.Value.toString v_)


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | togglePosition : M3e.Value.Supported } msg
togglePosition v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpansionPanel.togglePosition
        (M3e.Value.toString v_)


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpansionPanel.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpansionPanel.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpansionPanel.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpansionPanel.onClosed
        (Json.Decode.succeed f_)