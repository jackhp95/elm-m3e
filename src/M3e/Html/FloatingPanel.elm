module M3e.Html.FloatingPanel exposing (floatingPanel, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle)

{-| Middle layer for `<m3e-floating-panel>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FloatingPanel` module for everyday use.

@docs floatingPanel, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.FloatingPanel
import M3e.Token


{-| A lightweight, generic floating surface used to present content above the page.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

-}
floatingPanel :
    List
        (M3e.Html.Attr.Attr
            { scrollStrategy : M3e.Token.Supported
            , fitAnchorWidth : M3e.Token.Supported
            , anchorOffset : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
floatingPanel attributes children =
    M3e.Raw.FloatingPanel.floatingPanel
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy :
    M3e.Token.Value
        { hide : M3e.Token.Supported
        , reposition : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | scrollStrategy : M3e.Token.Supported } msg
scrollStrategy v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FloatingPanel.scrollStrategy
        (M3e.Token.toString v_)


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
fitAnchorWidth : Bool -> M3e.Html.Attr.Attr { c | fitAnchorWidth : M3e.Token.Supported } msg
fitAnchorWidth =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FloatingPanel.fitAnchorWidth


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
anchorOffset : Float -> M3e.Html.Attr.Attr { c | anchorOffset : M3e.Token.Supported } msg
anchorOffset =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FloatingPanel.anchorOffset


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : msg -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FloatingPanel.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events.
-}
onToggle : msg -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FloatingPanel.onToggle
        (Json.Decode.succeed f_)
