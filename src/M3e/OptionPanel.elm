module M3e.OptionPanel exposing
    ( view, state, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle
    , onToggle, noData, loading
    )

{-| Presents a list of options on a temporary surface.

**Component Info:**

  - **Extends:** `M3eFloatingPanelElement`

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

@docs view, state, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle
@docs onToggle, noData, loading

-}

import M3e.Html.OptionPanel
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-option-panel>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { state : M3e.Token.Supported
            , scrollStrategy : M3e.Token.Supported
            , fitAnchorWidth : M3e.Token.Supported
            , anchorOffset : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { option : M3e.Kind.Brand
                , optgroup : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | optionPanel : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.OptionPanel.optionPanel
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The state for which to present content. (default: `"content"`)
-}
state :
    M3e.Token.Value
        { content : M3e.Token.Supported
        , loading : M3e.Token.Supported
        , noData : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | state : M3e.Token.Supported } msg
state =
    M3e.Html.OptionPanel.state


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy :
    M3e.Token.Value
        { hide : M3e.Token.Supported
        , reposition : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | scrollStrategy : M3e.Token.Supported } msg
scrollStrategy =
    M3e.Html.OptionPanel.scrollStrategy


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
fitAnchorWidth :
    Bool
    -> Markup.Html.Attr.Attr { c | fitAnchorWidth : M3e.Token.Supported } msg
fitAnchorWidth =
    M3e.Html.OptionPanel.fitAnchorWidth


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
anchorOffset :
    Float
    -> Markup.Html.Attr.Attr { c | anchorOffset : M3e.Token.Supported } msg
anchorOffset =
    M3e.Html.OptionPanel.anchorOffset


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    msg
    -> Markup.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.OptionPanel.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle : msg -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.OptionPanel.onToggle


{-| Place content in the `no-data` slot.
-}
noData : Markup.Element.Element any msg -> Markup.Element.Element k msg
noData el =
    Markup.Element.Internal.placeSlot "no-data" el


{-| Place content in the `loading` slot.
-}
loading :
    Markup.Element.Element
        { circularProgressIndicator : M3e.Kind.Brand
        , loadingIndicator : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        }
        msg
    -> Markup.Element.Element k msg
loading el =
    Markup.Element.Internal.placeSlot "loading" el
