module M3e.Html.Fab exposing
    ( fab, disabled, disabledInteractive, download, extended, href
    , lowered, name, rel, size, target, type_
    , value, variant, onClick
    )

{-| Middle layer for `<m3e-fab>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Fab` module for everyday use.

@docs fab, disabled, disabledInteractive, download, extended, href
@docs lowered, name, rel, size, target, type_
@docs value, variant, onClick

-}

import Html
import Json.Decode
import M3e.Raw.Fab
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A floating action button (FAB) used to present important actions.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `label`: Renders the label of an extended button.
  - `close-icon`: Renders the close icon when used to open a FAB menu.

-}
fab :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , download : M3e.Token.Supported
            , extended : M3e.Token.Supported
            , href : M3e.Token.Supported
            , lowered : M3e.Token.Supported
            , name : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , size : M3e.Token.Supported
            , target : M3e.Token.Supported
            , type_ : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
fab attributes children =
    M3e.Raw.Fab.fab (List.map Markup.Html.Attr.toAttribute attributes) children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.disabled


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | disabledInteractive : M3e.Token.Supported
            }
            msg
disabledInteractive =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.disabledInteractive


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Markup.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.download


{-| Whether the button is extended to show the label. (default: `false`)
-}
extended : Bool -> Markup.Html.Attr.Attr { c | extended : M3e.Token.Supported } msg
extended =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.extended


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Markup.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.href


{-| Whether to present a lowered elevation. (default: `false`)
-}
lowered : Bool -> Markup.Html.Attr.Attr { c | lowered : M3e.Token.Supported } msg
lowered =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.lowered


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.name


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Markup.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.rel


{-| The size of the button. (default: `"medium"`)
-}
size :
    M3e.Token.Value
        { large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size v_ =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.size (M3e.Token.toString v_)


{-| The target of the link button. (default: `""`)
-}
target : String -> Markup.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.target


{-| The type of the element. (default: `"button"`)
-}
type_ :
    M3e.Token.Value
        { button : M3e.Token.Supported
        , reset : M3e.Token.Supported
        , submit : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
type_ v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Fab.type_
        (M3e.Token.toString v_)


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Fab.value


{-| The appearance variant of the button. (default: `"primary-container"`)
-}
variant :
    M3e.Token.Value
        { primary : M3e.Token.Supported
        , primaryContainer : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        , secondaryContainer : M3e.Token.Supported
        , surface : M3e.Token.Supported
        , tertiary : M3e.Token.Supported
        , tertiaryContainer : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Fab.variant
        (M3e.Token.toString v_)


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Fab.onClick
        (Json.Decode.succeed f_)
