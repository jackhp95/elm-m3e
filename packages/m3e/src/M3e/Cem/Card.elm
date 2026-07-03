module M3e.Cem.Card exposing
    ( card, actionable, inline, orientation, variant, href
    , target, rel, download, name, value, type_, disabledInteractive
    , disabled, onClick
    )

{-|
Middle layer for `<m3e-card>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Card` module for everyday use.

@docs card, actionable, inline, orientation, variant, href
@docs target, rel, download, name, value, type_
@docs disabledInteractive, disabled, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.Card
import M3e.Value


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
    List (M3e.Cem.Attr.Attr { actionable : M3e.Value.Supported
    , inline : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , download : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
card attributes children =
    M3e.Cem.Html.Card.card
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
actionable :
    Bool -> M3e.Cem.Attr.Attr { c | actionable : M3e.Value.Supported } msg
actionable =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.actionable


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
inline : Bool -> M3e.Cem.Attr.Attr { c | inline : M3e.Value.Supported } msg
inline =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.inline


{-| The orientation of the card. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.orientation (M3e.Value.toString v_)


{-| The appearance variant of the card. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.variant (M3e.Value.toString v_)


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.href


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.target


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.rel


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.download


{-| The name of the element, submitted as a pair with the element's `value`
as part of form data, when the element is used to submit a form.
-}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.name


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.value


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.type_ (M3e.Value.toString v_)


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.disabledInteractive


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.disabled


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Card.onClick (Json.Decode.succeed f_)