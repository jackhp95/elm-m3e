module M3e.Chip exposing
    ( Option, ViewOption
    , view, assist, suggestion, filter, input
    , onClick, selected, disabled, elevated, href, removeLabel, leadingIcon, avatarChild
    , viewElevated, viewLeadingIcon
    )

{-| `<m3e-*-chip>` family — compact, often dynamic choices.

Spec (per docs/CONVENTIONS.md):

  - `view {label}` → `<m3e-chip>` (display, non-interactive)
    ViewOption: viewElevated, viewLeadingIcon
  - `assist {label, onClick}` → `<m3e-assist-chip>`
  - `suggestion {label, onClick}` → `<m3e-suggestion-chip>`
  - `filter {label, onToggle}` → `<m3e-filter-chip>`
  - `input {label, onRemove}` → `<m3e-input-chip>` (always removable)
  - Interactive chips return `Element { s | chip : Supported }` (fits ChipSet.chips)
  - Options (interactive, shared): onClick, selected, disabled, elevated, href,
    removeLabel, leadingIcon, avatarChild
  - Properties: selected, disabled, removable (DOM)
  - Attrs: variant (elevated/outlined), href, remove-label
  - Slots: icon (leadingIcon); avatar (avatarChild — input chips)
  - Escape: none (leaves)
  - Tag: chip

The kind-specific action (`onClick`/`onToggle`/`onRemove`) is a required
constructor argument, not an option — a chip can't be built without the
behaviour its kind demands.


# Types

@docs Option, ViewOption


# Chips

@docs view, assist, suggestion, filter, input


# Options (interactive chips)

@docs onClick, selected, disabled, elevated, href, removeLabel, leadingIcon, avatarChild


# Options (display chip)

@docs viewElevated, viewLeadingIcon

-}

import Cem.M3e.Chip as CemChip
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- OPTION TYPE (interactive chips) ----------------------------------------


{-| An opaque option for the interactive chips (`assist`, `suggestion`,
`filter`, `input`).
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Override the click handler (assist/suggestion chips set it from their
required argument; this lets options replace it).
-}
onClick : msg -> Option msg
onClick m =
    Internal.option (\c -> { c | onClick = Just m })


{-| Set the chip's selected state (the `selected` DOM property).
-}
selected : Bool -> Option msg
selected b =
    Internal.option (\c -> { c | selected = b })


{-| Disable the chip (the `disabled` DOM property).
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Use the elevated variant rather than outlined.
-}
elevated : Bool -> Option msg
elevated b =
    Internal.option (\c -> { c | elevated = b })


{-| Render the chip as a link to the given URL (sets the `href` attribute).
-}
href : String -> Option msg
href v =
    Internal.option (\c -> { c | href = Just v })


{-| Accessible label for the remove button (the `remove-label` attribute).
-}
removeLabel : String -> Option msg
removeLabel v =
    Internal.option (\c -> { c | removeLabel = Just v })


{-| Add a leading icon (rendered in the `icon` slot).
-}
leadingIcon : Element { icon : Supported } msg -> Option msg
leadingIcon i =
    Internal.option (\c -> { c | leadingIcon = Just i })


{-| Render an avatar before the label (input chips only — `slot="avatar"`).
-}
avatarChild : Element { avatar : Supported } msg -> Option msg
avatarChild a =
    Internal.option (\c -> { c | avatarChild = Just a })



-- OPTION TYPE (display chip only) ----------------------------------------


{-| Options accepted by the display `view` chip. Narrow subset matching
`<m3e-chip>`'s real CEM surface (variant + icon slot).
-}
type alias ViewOption msg =
    Internal.Option (ViewConfig msg) msg


{-| Set the elevated variant on the display chip.
-}
viewElevated : Bool -> ViewOption msg
viewElevated b =
    Internal.option (\c -> { c | elevated = b })


{-| Add a leading icon to the display chip (rendered in the `icon` slot).
-}
viewLeadingIcon : Element { icon : Supported } msg -> ViewOption msg
viewLeadingIcon i =
    Internal.option (\c -> { c | leadingIcon = Just i })



-- CONFIG -----------------------------------------------------------------


type alias Config msg =
    { onClick : Maybe msg
    , selected : Bool
    , disabled : Bool
    , elevated : Bool
    , href : Maybe String
    , removeLabel : Maybe String
    , leadingIcon : Maybe (Element { icon : Supported } msg)
    , avatarChild : Maybe (Element { avatar : Supported } msg)
    }


defaultConfig : Config msg
defaultConfig =
    { onClick = Nothing
    , selected = False
    , disabled = False
    , elevated = False
    , href = Nothing
    , removeLabel = Nothing
    , leadingIcon = Nothing
    , avatarChild = Nothing
    }



-- CONFIG (display chip) --------------------------------------------------


type alias ViewConfig msg =
    { elevated : Bool
    , leadingIcon : Maybe (Element { icon : Supported } msg)
    }


defaultViewConfig : ViewConfig msg
defaultViewConfig =
    { elevated = False, leadingIcon = Nothing }



-- SLOT / ATTR HELPERS ----------------------------------------------------


iconChild : Config msg -> Maybe (Node msg)
iconChild c =
    Maybe.map
        (\i -> Node.withSlot "icon" (Element.toNode i))
        c.leadingIcon


variantAttr : Config msg -> Node.Attr msg
variantAttr c =
    Node.attribute "variant"
        (CemChip.variantToString
            (if c.elevated then
                CemChip.Elevated

             else
                CemChip.Outlined
            )
        )


disabledAttr : Config msg -> Maybe (Node.Attr msg)
disabledAttr c =
    Just (Node.property "disabled" (Encode.bool c.disabled))



-- VIEW (display chip — m3e-chip) ----------------------------------------


{-| Display (`<m3e-chip>`) — non-interactive, informational. Accepts
`ViewOption` only; the full `Option` set (onClick, disabled, etc.) is not
honoured by this element and is therefore not available here.
-}
view : { label : String } -> List (ViewOption msg) -> Element { s | chip : Supported } msg
view req opts =
    let
        vc : ViewConfig msg
        vc =
            Internal.applyOptions opts defaultViewConfig
    in
    Internal.fromNode
        (Node.element "m3e-chip"
            [ Node.attribute "variant"
                (CemChip.variantToString
                    (if vc.elevated then
                        CemChip.Elevated

                     else
                        CemChip.Outlined
                    )
                )
            ]
            (List.filterMap identity
                [ Maybe.map (\i -> Node.withSlot "icon" (Element.toNode i)) vc.leadingIcon
                , Just (Node.text req.label)
                ]
            )
        )



-- ASSIST -----------------------------------------------------------------


{-| Assist chip (`<m3e-assist-chip>`) — suggests an action. Requires an
`onClick` handler.
-}
assist :
    { label : String, onClick : msg }
    -> List (Option msg)
    -> Element { s | chip : Supported } msg
assist req opts =
    genericChip "m3e-assist-chip" req.label req.onClick opts


{-| Suggestion chip (`<m3e-suggestion-chip>`) — a dynamically generated
suggestion. Requires an `onClick` handler.
-}
suggestion :
    { label : String, onClick : msg }
    -> List (Option msg)
    -> Element { s | chip : Supported } msg
suggestion req opts =
    genericChip "m3e-suggestion-chip" req.label req.onClick opts


{-| Shared rendering for assist/suggestion chips: a link when `href` is set,
otherwise the required `onClick`.
-}
genericChip : String -> String -> msg -> List (Option msg) -> Element { s | chip : Supported } msg
genericChip tag label clickMsg opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts { defaultConfig | onClick = Just clickMsg }

        action : Maybe (Node.Attr msg)
        action =
            case c.href of
                Just url ->
                    Just (Node.attribute "href" url)

                Nothing ->
                    Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
    in
    Internal.fromNode
        (Node.element tag
            (List.filterMap identity
                [ Just (variantAttr c)
                , disabledAttr c
                , action
                ]
            )
            (List.filterMap identity
                [ iconChild c
                , Just (Node.text label)
                ]
            )
        )



-- FILTER -----------------------------------------------------------------


{-| Filter chip (`<m3e-filter-chip>`) — toggles a filter on/off. Requires an
`onToggle` handler (fired on `change`).
-}
filter :
    { label : String, onToggle : msg }
    -> List (Option msg)
    -> Element { s | chip : Supported } msg
filter req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-filter-chip"
            (List.filterMap identity
                [ Just (variantAttr c)
                , Just (Node.property "selected" (Encode.bool c.selected))
                , disabledAttr c
                , Just (Node.on "change" (Decode.succeed req.onToggle))
                ]
            )
            (List.filterMap identity
                [ iconChild c
                , Just (Node.text req.label)
                ]
            )
        )



-- INPUT ------------------------------------------------------------------


{-| Input chip (`<m3e-input-chip>`) — represents a user-entered value; always
removable. Requires an `onRemove` handler.
-}
input :
    { label : String, onRemove : msg }
    -> List (Option msg)
    -> Element { s | chip : Supported } msg
input req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-input-chip"
            (List.filterMap identity
                [ Just (variantAttr c)
                , Just (Node.property "removable" (Encode.bool True))
                , disabledAttr c
                , Maybe.map (Node.attribute "remove-label") c.removeLabel
                , Just (Node.on "remove" (Decode.succeed req.onRemove))
                ]
            )
            (List.filterMap identity
                [ Maybe.map (\a -> Node.withSlot "avatar" (Element.toNode a)) c.avatarChild
                , iconChild c
                , Just (Node.text req.label)
                ]
            )
        )
