module M3e.Html.SegmentedButton exposing
    ( segmentedButton, disabled, hideSelectionIndicator, multi, name, onChange
    , onBeforeinput, onInput
    )

{-| Middle layer for `<m3e-segmented-button>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SegmentedButton` module for everyday use.

@docs segmentedButton, disabled, hideSelectionIndicator, multi, name, onChange
@docs onBeforeinput, onInput

-}

import Html
import Json.Decode
import M3e.Raw.SegmentedButton
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A button that allows a user to select from a limited set of options.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the checked state of a segment changes.
  - `beforeinput`: Dispatched before the checked state of a segment changes.
  - `input`: Dispatched when the checked state of a segment changes.

-}
segmentedButton :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , hideSelectionIndicator : M3e.Token.Supported
            , multi : M3e.Token.Supported
            , name : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
segmentedButton attributes children =
    M3e.Raw.SegmentedButton.segmentedButton
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SegmentedButton.disabled


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
hideSelectionIndicator =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SegmentedButton.hideSelectionIndicator


{-| Whether multiple options can be selected. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SegmentedButton.multi


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SegmentedButton.name


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SegmentedButton.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SegmentedButton.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SegmentedButton.onInput
        (Json.Decode.succeed f_)
