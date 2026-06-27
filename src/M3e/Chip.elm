module M3e.Chip exposing
    ( Option
    , view
    , assist, suggestion, filter, input
    , onClick, selected, disabled, elevated, href, removeLabel, leadingIcon, avatarChild
    )

{-| `<m3e-*-chip>` family — compact, often dynamic choices.

Spec (per docs/CONVENTIONS.md):

  - `view {label}`              → `<m3e-chip>` (display, non-interactive)
  - `assist {label, onClick}`   → `<m3e-assist-chip>`
  - `suggestion {label, onClick}` → `<m3e-suggestion-chip>`
  - `filter {label, onToggle}`  → `<m3e-filter-chip>`
  - `input {label, onRemove}`   → `<m3e-input-chip>` (always removable)
  - All return `Renderable { s | chip : Supported }` (fits ChipSet.withChips)
  - Options (shared): onClick, selected, disabled, elevated, href, removeLabel,
                      leadingIcon, avatarChild
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



-- OPTION TYPE ------------------------------------------------------------


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


view : { label : String } -> List (Option msg) -> Renderable { s | chip : Supported } msg
view req opts =
    let
        c =
            List.foldl apply defaultConfig opts
    in
    Internal.fromNode
        (Node.element "m3e-chip"
            (List.filterMap identity
                [ Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                ]
            )
            [ Node.text req.label ]
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
