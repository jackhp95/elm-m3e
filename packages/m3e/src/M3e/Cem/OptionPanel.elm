module M3e.Cem.OptionPanel exposing
    ( optionPanel, state, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle
    , onToggle
    )

{-|
Middle layer for `<m3e-option-panel>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.OptionPanel` module for everyday use.

@docs optionPanel, state, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle
@docs onToggle
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.OptionPanel
import M3e.Value


{-| Presents a list of options on a temporary surface.

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.
-}
optionPanel :
    List (M3e.Cem.Attr.Attr { state : M3e.Value.Supported
    , scrollStrategy : M3e.Value.Supported
    , fitAnchorWidth : M3e.Value.Supported
    , anchorOffset : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
optionPanel attributes children =
    M3e.Cem.Html.OptionPanel.optionPanel
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The state for which to present content. (default: `"content"`) -}
state :
    M3e.Value.Value { content : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , noData : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | state : M3e.Value.Supported } msg
state v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.OptionPanel.state
        (M3e.Value.toString v_)


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategy :
    M3e.Value.Value { hide : M3e.Value.Supported
    , reposition : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scrollStrategy : M3e.Value.Supported } msg
scrollStrategy v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.OptionPanel.scrollStrategy
        (M3e.Value.toString v_)


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth :
    Bool -> M3e.Cem.Attr.Attr { c | fitAnchorWidth : M3e.Value.Supported } msg
fitAnchorWidth =
    M3e.Cem.Attr.attribute M3e.Cem.Html.OptionPanel.fitAnchorWidth


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset :
    Float -> M3e.Cem.Attr.Attr { c | anchorOffset : M3e.Value.Supported } msg
anchorOffset =
    M3e.Cem.Attr.attribute M3e.Cem.Html.OptionPanel.anchorOffset


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.OptionPanel.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.OptionPanel.onToggle
        (Json.Decode.succeed f_)