module M3e.Cem.NavItem exposing
    ( navItem, disabled, disabledInteractive, download, href, orientation
    , rel, selected, target, onBeforeinput, onInput, onChange, onClick
    )

{-|
Middle layer for `<m3e-nav-item>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.NavItem` module for everyday use.

@docs navItem, disabled, disabledInteractive, download, href, orientation
@docs rel, selected, target, onBeforeinput, onInput, onChange
@docs onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.NavItem
import M3e.Value


{-| An item, placed in a navigation bar or rail, used to navigate to destinations in an application.

**Events:**
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.
- `change`: Dispatched when the selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders the icon of the item.
- `selected-icon`: Renders the icon of the item when selected.
-}
navItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , target : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
navItem attributes children =
    M3e.Cem.Html.NavItem.navItem
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavItem.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavItem.disabledInteractive


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavItem.download


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavItem.href


{-| The layout orientation of the item. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavItem.orientation
        (M3e.Value.toString v_)


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavItem.rel


{-| A value indicating whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavItem.selected


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavItem.target


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavItem.onBeforeinput
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavItem.onInput
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavItem.onChange
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavItem.onClick (Json.Decode.succeed f_)