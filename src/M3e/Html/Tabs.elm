module M3e.Html.Tabs exposing
    ( tabs, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
    , variant, onChange, onBeforeinput, onInput
    )

{-| Middle layer for `<m3e-tabs>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Tabs` module for everyday use.

@docs tabs, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
@docs variant, onChange, onBeforeinput, onInput

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Tabs
import M3e.Token


{-| Organizes content into separate views where only one view can be visible at a time.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the selected tab changes.
  - `beforeinput`: Dispatched before the selected state of a tab changes.
  - `input`: Dispatched when the selected state of a tab changes.

**Slots:**

  - `panel`: Renders the panels of the tabs.
  - `next-icon`: Renders the icon to present for the next button used to paginate.
  - `prev-icon`: Renders the icon to present for the previous button used to paginate.

-}
tabs :
    List
        (M3e.Html.Attr.Attr
            { disablePagination : M3e.Token.Supported
            , headerPosition : M3e.Token.Supported
            , nextPageLabel : M3e.Token.Supported
            , previousPageLabel : M3e.Token.Supported
            , stretch : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
tabs attributes children =
    M3e.Raw.Tabs.tabs (List.map M3e.Html.Attr.toAttribute attributes) children


{-| Whether scroll buttons are disabled.
-}
disablePagination :
    M3e.Token.Value
        { true : M3e.Token.Supported
        , false : M3e.Token.Supported
        , auto : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePagination v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Tabs.disablePagination
        (M3e.Token.toString v_)


{-| The position of the tab headers. (default: `"before"`)
-}
headerPosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPosition v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Tabs.headerPosition
        (M3e.Token.toString v_)


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel : String -> M3e.Html.Attr.Attr { c | nextPageLabel : M3e.Token.Supported } msg
nextPageLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Tabs.nextPageLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousPageLabel : M3e.Token.Supported } msg
previousPageLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Tabs.previousPageLabel


{-| Whether tabs are stretched to fill the header. (default: `false`)
-}
stretch : Bool -> M3e.Html.Attr.Attr { c | stretch : M3e.Token.Supported } msg
stretch =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Tabs.stretch


{-| The appearance variant of the tabs. (default: `"secondary"`)
-}
variant :
    M3e.Token.Value
        { primary : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Tabs.variant
        (M3e.Token.toString v_)


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Tabs.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Tabs.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Tabs.onInput
        (Json.Decode.succeed f_)
