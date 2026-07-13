module M3e.Html.ExpansionPanel exposing
    ( expansionPanel, disabled, hideToggle, open, toggleDirection, togglePosition
    , onOpening, onOpened, onClosing, onClosed
    )

{-| Middle layer for `<m3e-expansion-panel>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ExpansionPanel` module for everyday use.

@docs expansionPanel, disabled, hideToggle, open, toggleDirection, togglePosition
@docs onOpening, onOpened, onClosing, onClosed

-}

import Html
import Json.Decode
import M3e.Raw.ExpansionPanel
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An expandable details-summary view.

**Component Info:**

  - **Extends:** `LitElement`

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
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , hideToggle : M3e.Token.Supported
            , open : M3e.Token.Supported
            , toggleDirection : M3e.Token.Supported
            , togglePosition : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
expansionPanel attributes children =
    M3e.Raw.ExpansionPanel.expansionPanel
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.ExpansionPanel.disabled


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> Markup.Html.Attr.Attr { c | hideToggle : M3e.Token.Supported } msg
hideToggle =
    Markup.Html.Attr.Internal.attribute M3e.Raw.ExpansionPanel.hideToggle


{-| Whether the panel is expanded. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    Markup.Html.Attr.Internal.attribute M3e.Raw.ExpansionPanel.open


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirection v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.ExpansionPanel.toggleDirection
        (M3e.Token.toString v_)


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePosition v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.ExpansionPanel.togglePosition
        (M3e.Token.toString v_)


{-| Listen for `opening` events.
-}
onOpening : msg -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.ExpansionPanel.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events.
-}
onOpened : msg -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.ExpansionPanel.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events.
-}
onClosing : msg -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.ExpansionPanel.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events.
-}
onClosed : msg -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.ExpansionPanel.onClosed
        (Json.Decode.succeed f_)
