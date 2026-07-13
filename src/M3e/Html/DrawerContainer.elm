module M3e.Html.DrawerContainer exposing
    ( drawerContainer, end, endMode, endDivider, start, startMode
    , startDivider, onChange
    )

{-| Middle layer for `<m3e-drawer-container>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.DrawerContainer` module for everyday use.

@docs drawerContainer, end, endMode, endDivider, start, startMode
@docs startDivider, onChange

-}

import Html
import Json.Decode
import M3e.Raw.DrawerContainer
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A container for one or two sliding drawers.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the state of the start or end drawers change.

**Slots:**

  - `start`: Renders the start drawer.
  - `end`: Renders the end drawer.

-}
drawerContainer :
    List
        (Markup.Html.Attr.Attr
            { end : M3e.Token.Supported
            , endMode : M3e.Token.Supported
            , endDivider : M3e.Token.Supported
            , start : M3e.Token.Supported
            , startMode : M3e.Token.Supported
            , startDivider : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
drawerContainer attributes children =
    M3e.Raw.DrawerContainer.drawerContainer
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the end drawer is open. (default: `false`)
-}
end : Bool -> Markup.Html.Attr.Attr { c | end : M3e.Token.Supported } msg
end =
    Markup.Html.Attr.Internal.attribute M3e.Raw.DrawerContainer.end


{-| The behavior mode of the end drawer. (default: `"side"`)
-}
endMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endMode v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.DrawerContainer.endMode
        (M3e.Token.toString v_)


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`)
-}
endDivider : Bool -> Markup.Html.Attr.Attr { c | endDivider : M3e.Token.Supported } msg
endDivider =
    Markup.Html.Attr.Internal.attribute M3e.Raw.DrawerContainer.endDivider


{-| Whether the start drawer is open. (default: `false`)
-}
start : Bool -> Markup.Html.Attr.Attr { c | start : M3e.Token.Supported } msg
start =
    Markup.Html.Attr.Internal.attribute M3e.Raw.DrawerContainer.start


{-| The behavior mode of the start drawer. (default: `"side"`)
-}
startMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startMode v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.DrawerContainer.startMode
        (M3e.Token.toString v_)


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`)
-}
startDivider : Bool -> Markup.Html.Attr.Attr { c | startDivider : M3e.Token.Supported } msg
startDivider =
    Markup.Html.Attr.Internal.attribute M3e.Raw.DrawerContainer.startDivider


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.DrawerContainer.onChange
        (Json.Decode.succeed f_)
