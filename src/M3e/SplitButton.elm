module M3e.SplitButton exposing
    ( view
    , Option
    , variant, size, disabled
    )

{-| `<m3e-split-button>` — a primary action button paired with a trailing
icon-button trigger for related actions.

Spec (per docs/CONVENTIONS.md):

  - Required: { label : String
    , name : String -- a11y label for the trailing icon-button
    , trailingContent : List (Element { icon : Supported, element : Supported } msg) -- content for the trailing icon-button
    , onPrimaryClick : msg -- handler for the leading button
    , onTriggerClick : msg -- handler for the trailing icon-button
    }
  - Options: variant, size, disabled
  - Slots: "leading-button" ← `<m3e-button>` (the primary action)
    "trailing-button" ← `<m3e-icon-button>` (the dropdown trigger)
  - Properties: none (variant/size are string attributes)
  - Attrs: variant/size via Node.rawAttr (Cem enum)
  - Escape: none (strict: leading-button and trailing-button are fixed kinds)
  - Tag: splitButton

BUG FIX #16: the previous `Ui.SplitButton` slotted native `<button>` elements,
but `<m3e-split-button>` adopts only `<m3e-button>` / `<m3e-icon-button>`. This
port emits the correct element types by constructing the slot children via
`M3e.Button.view` and a hand-built `<m3e-icon-button>` node respectively.

@docs view
@docs Option
@docs variant, size, disabled

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Attr as Attr
import M3e.Button as Button
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Value as Value exposing (AxisSupports, Value)


{-| Appearance variant (default `filled`), supplied as shared
[`M3e.Value`](M3e-Value) tokens. The variant is forwarded verbatim to the
leading `<m3e-button>`, so the full button variant row is accepted.
-}
type alias Variants =
    Value
        { elevated : Supported
        , filled : Supported
        , tonal : Supported
        , outlined : Supported
        , text : Supported
        }


{-| Button sizes — `extraSmall` through `extraLarge` (default `small`),
supplied as shared [`M3e.Value`](M3e-Value) tokens.

Upstream: `<m3e-split-button size="...">` attribute.

-}
type alias Sizes =
    { extraSmall : Supported
    , small : Supported
    , medium : Supported
    , large : Supported
    , extraLarge : Supported
    }


{-| An option configuring a split button.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the appearance variant (default
[`M3e.Value.filled`](M3e-Value#filled)).
-}
variant : Variants -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


{-| Set the button size (default [`M3e.Value.small`](M3e-Value#small)).

Upstream: `size` attribute on `<m3e-split-button>`.

-}
size : Value Sizes -> Option msg
size =
    Attr.size


{-| Disable both the leading and trailing buttons.
-}
disabled : Bool -> Option msg
disabled =
    Attr.disabled


type alias Config =
    { variant : Variants
    , size : AxisSupports Sizes
    , disabled : Bool
    }


{-| Render the split button: a leading `<m3e-button>` (the primary action)
paired with a trailing `<m3e-icon-button>` whose light-DOM children are
supplied by the caller via `trailingContent`.

    SplitButton.view
        { label = "Send"
        , name = "Schedule send"
        , trailingContent = [ Icon.view { name = "schedule_send" } [] ]
        , onPrimaryClick = SendMessage
        , onTriggerClick = ScheduleSend
        }
        [ SplitButton.variant M3e.Value.filled ]

To also open a menu from the trailing button, add `Menu.triggerFor` alongside
the icon:

    trailingContent =
        [ Icon.view { name = "expand_more" } []
        , Menu.triggerFor "my-menu"
        ]

-}
view :
    { label : String
    , name : String
    , trailingContent : List (Element { icon : Supported, element : Supported } msg)
    , onPrimaryClick : msg
    , onTriggerClick : msg
    }
    -> List (Option msg)
    -> Element { s | splitButton : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { variant = Value.filled, size = Value.emptyAxis, disabled = False }

        -- Leading button: m3e-button (FIX #16 — not a native <button>)
        leadingButton : Node msg
        leadingButton =
            Button.view
                { label = req.label, variant = c.variant }
                (List.filterMap identity
                    [ Just (Button.onClick req.onPrimaryClick)
                    , if c.disabled then
                        Just (Button.disabled True)

                      else
                        Nothing
                    ]
                )
                |> Element.toNode
                |> Node.withSlot "leading-button"

        -- Trailing button: m3e-icon-button (FIX #16 — not a native <button>)
        -- trailingContent is the typed slot input — any element(s) go here,
        -- enabling both the icon and companions like m3e-menu-trigger.
        trailingButton : Node msg
        trailingButton =
            Node.element "m3e-icon-button"
                [ Node.attribute "aria-label" req.name
                , Node.property "disabled" (Encode.bool c.disabled)
                , Node.on "click" (Decode.succeed req.onTriggerClick)
                ]
                (List.map Element.toNode req.trailingContent)
                |> Node.withSlot "trailing-button"
    in
    Internal.fromNode
        (Node.element "m3e-split-button"
            [ Node.attribute "variant" (Value.toString c.variant)
            , Node.attribute "size" (Value.axisStringOr Value.small c.size)
            ]
            [ leadingButton, trailingButton ]
        )
