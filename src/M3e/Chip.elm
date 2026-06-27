module M3e.Chip exposing
    ( Option, ViewOption
    , view
    , assist, suggestion, filter, input
    , onClick, selected, disabled, elevated, href, removeLabel, leadingIcon, avatarChild
    , viewElevated, viewLeadingIcon
    )

{-| `<m3e-*-chip>` family — compact, often dynamic choices.

Spec (per docs/CONVENTIONS.md):

  - `view {label}`              → `<m3e-chip>` (display, non-interactive)
                                   ViewOption: viewElevated, viewLeadingIcon
  - `assist {label, onClick}`   → `<m3e-assist-chip>`
  - `suggestion {label, onClick}` → `<m3e-suggestion-chip>`
  - `filter {label, onToggle}`  → `<m3e-filter-chip>`
  - `input {label, onRemove}`   → `<m3e-input-chip>` (always removable)
  - Interactive chips return `Renderable { s | chip : Supported }` (fits ChipSet.withChips)
  - Options (interactive, shared): onClick, selected, disabled, elevated, href,
                                   removeLabel, leadingIcon, avatarChild
  - Properties: selected, disabled, removable (DOM)
  - Attrs:      variant (elevated/outlined), href, remove-label
  - Slots:      icon (leadingIcon); avatar (avatarChild — input chips)
  - Escape:     none (leaves)
  - Tag:        chip

The kind-specific action (`onClick`/`onToggle`/`onRemove`) is a required
constructor argument, not an option — a chip can't be built without the
behaviour its kind demands.

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal



-- OPTION TYPE (interactive chips) ----------------------------------------


type Option msg
    = OnClick msg
    | Selected Bool
    | Disabled Bool
    | Elevated Bool
    | Href String
    | RemoveLabel String
    | LeadingIcon (Renderable { icon : Supported } msg)
    | AvatarChild (Renderable { avatar : Supported } msg)


onClick : msg -> Option msg
onClick =
    OnClick


selected : Bool -> Option msg
selected =
    Selected


disabled : Bool -> Option msg
disabled =
    Disabled


elevated : Bool -> Option msg
elevated =
    Elevated


href : String -> Option msg
href =
    Href


removeLabel : String -> Option msg
removeLabel =
    RemoveLabel


leadingIcon : Renderable { icon : Supported } msg -> Option msg
leadingIcon =
    LeadingIcon


{-| Render an avatar before the label (input chips only — `slot="avatar"`).
-}
avatarChild : Renderable { avatar : Supported } msg -> Option msg
avatarChild =
    AvatarChild



-- OPTION TYPE (display chip only) ----------------------------------------


{-| Options accepted by the display `view` chip. Narrow subset matching
`<m3e-chip>`'s real CEM surface (variant + icon slot). -}
type ViewOption msg
    = ViewElevated Bool
    | ViewLeadingIcon (Renderable { icon : Supported } msg)


{-| Set the elevated variant on the display chip. -}
viewElevated : Bool -> ViewOption msg
viewElevated =
    ViewElevated


{-| Add a leading icon to the display chip (rendered in the `icon` slot). -}
viewLeadingIcon : Renderable { icon : Supported } msg -> ViewOption msg
viewLeadingIcon =
    ViewLeadingIcon



-- CONFIG -----------------------------------------------------------------


type alias Config msg =
    { onClick : Maybe msg
    , selected : Bool
    , disabled : Bool
    , elevated : Bool
    , href : Maybe String
    , removeLabel : Maybe String
    , leadingIcon : Maybe (Renderable { icon : Supported } msg)
    , avatarChild : Maybe (Renderable { avatar : Supported } msg)
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


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        OnClick m ->
            { c | onClick = Just m }

        Selected b ->
            { c | selected = b }

        Disabled b ->
            { c | disabled = b }

        Elevated b ->
            { c | elevated = b }

        Href v ->
            { c | href = Just v }

        RemoveLabel v ->
            { c | removeLabel = Just v }

        LeadingIcon i ->
            { c | leadingIcon = Just i }

        AvatarChild a ->
            { c | avatarChild = Just a }



-- CONFIG (display chip) --------------------------------------------------


type alias ViewConfig msg =
    { elevated : Bool
    , leadingIcon : Maybe (Renderable { icon : Supported } msg)
    }


defaultViewConfig : ViewConfig msg
defaultViewConfig =
    { elevated = False, leadingIcon = Nothing }


applyView : ViewOption msg -> ViewConfig msg -> ViewConfig msg
applyView opt vc =
    case opt of
        ViewElevated b ->
            { vc | elevated = b }

        ViewLeadingIcon i ->
            { vc | leadingIcon = Just i }



-- SLOT / ATTR HELPERS ----------------------------------------------------


iconChild : Config msg -> Maybe (Node msg)
iconChild c =
    Maybe.map
        (\i -> Node.withSlot "icon" (Renderable.toNode i))
        c.leadingIcon


variantAttr : Config msg -> Node.Attr msg
variantAttr c =
    Node.attribute "variant"
        (if c.elevated then
            "elevated"

         else
            "outlined"
        )


disabledAttr : Config msg -> Maybe (Node.Attr msg)
disabledAttr c =
    if c.disabled then
        Just (Node.property "disabled" (Encode.bool True))

    else
        Nothing



-- VIEW (display chip — m3e-chip) ----------------------------------------


{-| Display (`<m3e-chip>`) — non-interactive, informational. Accepts
`ViewOption` only; the full `Option` set (onClick, disabled, etc.) is not
honoured by this element and is therefore not available here. -}
view : { label : String } -> List (ViewOption msg) -> Renderable { s | chip : Supported } msg
view req opts =
    let
        vc =
            List.foldl applyView defaultViewConfig opts
    in
    Internal.fromNode
        (Node.element "m3e-chip"
            [ Node.attribute "variant"
                (if vc.elevated then
                    "elevated"

                 else
                    "outlined"
                )
            ]
            (List.filterMap identity
                [ Maybe.map (\i -> Node.withSlot "icon" (Renderable.toNode i)) vc.leadingIcon
                , Just (Node.text req.label)
                ]
            )
        )



-- ASSIST -----------------------------------------------------------------


assist :
    { label : String, onClick : msg }
    -> List (Option msg)
    -> Renderable { s | chip : Supported } msg
assist req opts =
    genericChip "m3e-assist-chip" req.label req.onClick opts


suggestion :
    { label : String, onClick : msg }
    -> List (Option msg)
    -> Renderable { s | chip : Supported } msg
suggestion req opts =
    genericChip "m3e-suggestion-chip" req.label req.onClick opts


{-| Shared rendering for assist/suggestion chips: a link when `href` is set,
otherwise the required `onClick`.
-}
genericChip : String -> String -> msg -> List (Option msg) -> Renderable { s | chip : Supported } msg
genericChip tag label clickMsg opts =
    let
        c =
            List.foldl apply { defaultConfig | onClick = Just clickMsg } opts

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


filter :
    { label : String, onToggle : msg }
    -> List (Option msg)
    -> Renderable { s | chip : Supported } msg
filter req opts =
    let
        c =
            List.foldl apply defaultConfig opts
    in
    Internal.fromNode
        (Node.element "m3e-filter-chip"
            (List.filterMap identity
                [ Just (variantAttr c)
                , if c.selected then
                    Just (Node.property "selected" (Encode.bool True))

                  else
                    Nothing
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


input :
    { label : String, onRemove : msg }
    -> List (Option msg)
    -> Renderable { s | chip : Supported } msg
input req opts =
    let
        c =
            List.foldl apply defaultConfig opts
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
                [ Maybe.map (\a -> Node.withSlot "avatar" (Renderable.toNode a)) c.avatarChild
                , iconChild c
                , Just (Node.text req.label)
                ]
            )
        )
