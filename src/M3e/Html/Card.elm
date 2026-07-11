module M3e.Html.Card exposing
    ( card, actionable, inline, orientation, variant, href
    , target, rel, download, name, value, type_
    , disabledInteractive, disabled, onClick
    )

{-| Middle layer for `<m3e-card>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Card` module for everyday use.

@docs card, actionable, inline, orientation, variant, href
@docs target, rel, download, name, value, type_
@docs disabledInteractive, disabled, onClick

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Card
import M3e.Token


{-| A content container for text, images (or other media), and actions in the context of a single subject.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `header`: Renders the header of the card.
  - `content`: Renders the content of the card with padding.
  - `actions`: Renders the actions of the card.
  - `footer`: Renders the footer of the card.

-}
card :
    List
        (M3e.Html.Attr.Attr
            { actionable : M3e.Token.Supported
            , inline : M3e.Token.Supported
            , orientation : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , href : M3e.Token.Supported
            , target : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , download : M3e.Token.Supported
            , name : M3e.Token.Supported
            , value : M3e.Token.Supported
            , type_ : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
card attributes children =
    M3e.Raw.Card.card (List.map M3e.Html.Attr.toAttribute attributes) children


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`)
-}
actionable : Bool -> M3e.Html.Attr.Attr { c | actionable : M3e.Token.Supported } msg
actionable =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.actionable


{-| Whether to present the card inline with surrounding content. (default: `false`)
-}
inline : Bool -> M3e.Html.Attr.Attr { c | inline : M3e.Token.Supported } msg
inline =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.inline


{-| The orientation of the card. (default: `"vertical"`)
-}
orientation :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientation v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Card.orientation
        (M3e.Token.toString v_)


{-| The appearance variant of the card. (default: `"filled"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Card.variant
        (M3e.Token.toString v_)


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> M3e.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.href


{-| The target of the link button. (default: `""`)
-}
target : String -> M3e.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.target


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> M3e.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.rel


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download : String -> M3e.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.download


{-| The name of the element, submitted as a pair with the element's `value`
as part of form data, when the element is used to submit a form.
-}
name : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.name


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.value


{-| The type of the element. (default: `"button"`)
-}
type_ :
    M3e.Token.Value
        { button : M3e.Token.Supported
        , reset : M3e.Token.Supported
        , submit : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
type_ v_ =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.type_ (M3e.Token.toString v_)


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    -> M3e.Html.Attr.Attr { c | disabledInteractive : M3e.Token.Supported } msg
disabledInteractive =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.disabledInteractive


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Card.disabled


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Card.onClick
        (Json.Decode.succeed f_)
