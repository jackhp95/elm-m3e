module Ui.Chip exposing
    ( Chip, Filter, Input, Generic
    , assist, suggestion, filter, input
    , withSelected, withDisabled, withElevated, withIcon, withHref
    , view
    , Set, set, withId, withChip, withChips, setOnChange
    , viewSet
    )

{-| Typed builder for M3 chips. The four M3 chip kinds are separate constructors
that take their required collaborators up front, so a chip can't be built without
the behavior its kind demands, and a modifier that only makes sense for one kind
can't be applied to another.

The phantom `kind` parameter (`Filter` / `Input` / `Generic`) gates the
kind-specific modifiers and the typed sets:

  - [`assist`](#assist) / [`suggestion`](#suggestion) → `Chip Generic msg`:
    button-like / dynamically-generated actions. Both accept [`withHref`](#withHref)
    (link behavior) and live in the generic chip set.
  - [`filter`](#filter) → `Chip Filter msg`: a toggle. Accepts
    [`withSelected`](#withSelected); lives only in a filter set.
  - [`input`](#input) → `Chip Input msg`: represents an entity, with a required
    trailing remove; lives only in an input set.

Color is token-driven, not per-instance (M3 has no "colorable chip"); the only
visual axis is outlined (default) vs [`withElevated`](#withElevated), per spec.


# Chip construction

@docs Chip, Filter, Input, Generic
@docs assist, suggestion, filter, input


# Chip modifiers

@docs withSelected, withDisabled, withElevated, withIcon, withHref


# Render

@docs view


# Chip set

A set holds chips of a single kind — a filter set holds only filter chips, an
input set only input chips — so a heterogeneous set (which the M3e wrappers
can't represent) is a compile error rather than a silent downgrade.

@docs Set, set, withId, withChip, withChips, setOnChange


# Render set

@docs viewSet


# Figma Code Connect

Bound to bespoke `Ui.Chip.*` components on the `Ui.Chip` Figma page — one per
kind constructor. `entry=` names the kind constructor, `labelProp=Label` feeds
the chip label (the constructor record's `Html msg` field) from the Figma
`Label` text property, and the bool setters below map per kind: Filter toggles
`Selected`, and every kind toggles `Disabled`. The required action handlers
(`onClick`/`onToggle`/`onRemove`) are runtime data, rendered as the preview's
no-op placeholder. Leading icons (`withIcon`), the outlined/elevated style axis
(`withElevated`), and link behavior (`withHref`) are not mapped to Figma.

@figma-code-connect component=Assist entry=assist labelProp=Label node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=70575-96>
@figma-code-connect component=Filter entry=filter labelProp=Label node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=70575-89>
@figma-code-connect component=Suggestion entry=suggestion labelProp=Label node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=70575-103>
@figma-code-connect component=Input entry=input labelProp=Label node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=70575-110>

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.AssistChip
import M3e.Chip
import M3e.ChipSet
import M3e.FilterChip
import M3e.FilterChipSet
import M3e.InputChip
import M3e.InputChipSet
import M3e.SuggestionChip
import Ui.Icon


{-| A chip. The phantom `kind` is [`Filter`](#Filter), [`Input`](#Input), or
[`Generic`](#Generic) (assist/suggestion), gating the kind-specific modifiers.
-}
type Chip kind msg
    = Chip (ChipConfig msg)


{-| Phantom tag for [`filter`](#filter) chips.
-}
type Filter
    = Filter_ Never


{-| Phantom tag for [`input`](#input) chips.
-}
type Input
    = Input_ Never


{-| Phantom tag shared by [`assist`](#assist) and [`suggestion`](#suggestion)
chips (the generic chip family).
-}
type Generic
    = Generic_ Never


type Kind
    = Assist
    | Suggestion
    | FilterKind
    | InputKind


type alias ChipConfig msg =
    { id : String
    , kind : Kind
    , label : Html msg
    , onClick : Maybe msg
    , href : Maybe String
    , onToggle : Maybe msg
    , onRemove : Maybe msg
    , selected : Bool
    , disabled : Bool
    , elevated : Bool
    , icon : Maybe (Ui.Icon.Icon msg)
    }


defaultChip : String -> Kind -> Html msg -> ChipConfig msg
defaultChip id kind label =
    { id = id
    , kind = kind
    , label = label
    , onClick = Nothing
    , href = Nothing
    , onToggle = Nothing
    , onRemove = Nothing
    , selected = False
    , disabled = False
    , elevated = False
    , icon = Nothing
    }


{-| A button-like assist chip.
-}
assist : { id : String, label : Html msg, onClick : msg } -> Chip Generic msg
assist { id, label, onClick } =
    let
        base : ChipConfig msg
        base =
            defaultChip id Assist label
    in
    Chip { base | onClick = Just onClick }


{-| A suggestion chip (a dynamically-generated action).
-}
suggestion : { id : String, label : Html msg, onClick : msg } -> Chip Generic msg
suggestion { id, label, onClick } =
    let
        base : ChipConfig msg
        base =
            defaultChip id Suggestion label
    in
    Chip { base | onClick = Just onClick }


{-| A filter chip — a toggle. Pair with [`withSelected`](#withSelected) to drive
the selected state.
-}
filter : { id : String, label : Html msg, onToggle : msg } -> Chip Filter msg
filter { id, label, onToggle } =
    let
        base : ChipConfig msg
        base =
            defaultChip id FilterKind label
    in
    Chip { base | onToggle = Just onToggle }


{-| An input chip representing an entity. The trailing remove affordance is
required per spec, so `onRemove` is a constructor argument.
-}
input : { id : String, label : Html msg, onRemove : msg } -> Chip Input msg
input { id, label, onRemove } =
    let
        base : ChipConfig msg
        base =
            defaultChip id InputKind label
    in
    Chip { base | onRemove = Just onRemove }


{-| Mark a filter chip selected. Filter-only.

@figma-code-connect prop=Selected bool component=Filter

-}
withSelected : Bool -> Chip Filter msg -> Chip Filter msg
withSelected flag (Chip cfg) =
    Chip { cfg | selected = flag }


{-| Disable a chip. Valid on every kind.

@figma-code-connect prop=Disabled bool component=Assist,Filter,Suggestion,Input

-}
withDisabled : Bool -> Chip kind msg -> Chip kind msg
withDisabled flag (Chip cfg) =
    Chip { cfg | disabled = flag }


{-| Use the elevated style instead of the default outlined style. M3 reserves
elevated chips for image/busy backgrounds.
-}
withElevated : Bool -> Chip kind msg -> Chip kind msg
withElevated flag (Chip cfg) =
    Chip { cfg | elevated = flag }


{-| Add a leading icon.
-}
withIcon : Ui.Icon.Icon msg -> Chip kind msg -> Chip kind msg
withIcon icon (Chip cfg) =
    Chip { cfg | icon = Just icon }


{-| Make an assist/suggestion chip act as a link. The href takes precedence over
the constructor's `onClick`. Only available on [`assist`](#assist) /
[`suggestion`](#suggestion).

The actual navigation semantics (a focusable anchor, open-in-new-tab, etc.) are
provided by the underlying `<m3e-*-chip>` custom element from the `href`
attribute; this builder only sets that attribute.

-}
withHref : String -> Chip Generic msg -> Chip Generic msg
withHref url (Chip cfg) =
    Chip { cfg | href = Just url }


set : Set kind msg
set =
    Set { id = Nothing, chips = [], onChange = Nothing }


type Set kind msg
    = Set (SetConfig kind msg)


type alias SetConfig kind msg =
    { id : Maybe String
    , chips : List (Chip kind msg)
    , onChange : Maybe (String -> msg)
    }


withId : String -> Set kind msg -> Set kind msg
withId id (Set cfg) =
    Set { cfg | id = Just id }


withChip : Chip kind msg -> Set kind msg -> Set kind msg
withChip c (Set cfg) =
    Set { cfg | chips = cfg.chips ++ [ c ] }


withChips : List (Chip kind msg) -> Set kind msg -> Set kind msg
withChips cs (Set cfg) =
    Set { cfg | chips = cfg.chips ++ cs }


setOnChange : (String -> msg) -> Set kind msg -> Set kind msg
setOnChange handler (Set cfg) =
    Set { cfg | onChange = Just handler }


view : Chip kind msg -> Html msg
view (Chip cfg) =
    let
        iconChildren : List (Html msg)
        iconChildren =
            case cfg.icon of
                Just i ->
                    [ Html.span [ M3e.Chip.iconSlot ] [ Ui.Icon.view i ] ]

                Nothing ->
                    []

        children : List (Html msg)
        children =
            iconChildren ++ [ cfg.label ]

        on : (Decode.Decoder msg -> Html.Attribute msg) -> msg -> Html.Attribute msg
        on attr msg =
            attr (Decode.succeed msg)
    in
    case cfg.kind of
        Assist ->
            M3e.AssistChip.component
                (List.filterMap identity
                    [ Just (Attr.id cfg.id)
                    , Just (genericStyle cfg.elevated (M3e.AssistChip.variant M3e.AssistChip.Elevated) (M3e.AssistChip.variant M3e.AssistChip.Outlined))
                    , Just (M3e.AssistChip.disabled cfg.disabled)
                    , linkOrClick M3e.AssistChip.href (on M3e.AssistChip.onClick) cfg
                    ]
                )
                children

        Suggestion ->
            M3e.SuggestionChip.component
                (List.filterMap identity
                    [ Just (Attr.id cfg.id)
                    , Just (genericStyle cfg.elevated (M3e.SuggestionChip.variant M3e.SuggestionChip.Elevated) (M3e.SuggestionChip.variant M3e.SuggestionChip.Outlined))
                    , Just (M3e.SuggestionChip.disabled cfg.disabled)
                    , linkOrClick M3e.SuggestionChip.href (on M3e.SuggestionChip.onClick) cfg
                    ]
                )
                children

        FilterKind ->
            M3e.FilterChip.component
                (List.filterMap identity
                    [ Just (Attr.id cfg.id)
                    , Just (genericStyle cfg.elevated (M3e.FilterChip.variant M3e.FilterChip.Elevated) (M3e.FilterChip.variant M3e.FilterChip.Outlined))
                    , Just (M3e.FilterChip.selected cfg.selected)
                    , Just (M3e.FilterChip.disabled cfg.disabled)
                    , Maybe.map (on M3e.FilterChip.onChange) cfg.onToggle
                    ]
                )
                children

        InputKind ->
            M3e.InputChip.component
                (List.filterMap identity
                    [ Just (Attr.id cfg.id)
                    , Just (genericStyle cfg.elevated (M3e.InputChip.variant M3e.InputChip.Elevated) (M3e.InputChip.variant M3e.InputChip.Outlined))
                    , Just (M3e.InputChip.removable True)
                    , Just (M3e.InputChip.disabled cfg.disabled)
                    , Maybe.map (on M3e.InputChip.onRemove) cfg.onRemove
                    ]
                )
                children


{-| The outlined/elevated style attribute for a chip (default outlined).
-}
genericStyle : Bool -> Html.Attribute msg -> Html.Attribute msg -> Html.Attribute msg
genericStyle elevated elevatedAttr outlinedAttr =
    if elevated then
        elevatedAttr

    else
        outlinedAttr


{-| An assist/suggestion chip's action: a link when `href` is set, otherwise the
required `onClick`.
-}
linkOrClick : (String -> Html.Attribute msg) -> (msg -> Html.Attribute msg) -> ChipConfig msg -> Maybe (Html.Attribute msg)
linkOrClick hrefAttr clickAttr cfg =
    case cfg.href of
        Just url ->
            Just (hrefAttr url)

        Nothing ->
            Maybe.map clickAttr cfg.onClick


{-| Render a chip set. The set's kind determines the wrapper: a filter set uses
`FilterChipSet`, an input set uses `InputChipSet`, and a generic
(assist/suggestion) set uses the basic `ChipSet`. The phantom kind guarantees the
chips are homogeneous, so the wrapper choice is unambiguous.
-}
viewSet : Set kind msg -> Html msg
viewSet (Set cfg) =
    let
        baseAttrs : List (Html.Attribute msg)
        baseAttrs =
            List.filterMap identity [ Maybe.map Attr.id cfg.id ]

        wrapper : List (Html.Attribute msg) -> List (Html msg) -> Html msg
        wrapper =
            case List.head cfg.chips of
                Just (Chip c) ->
                    case c.kind of
                        FilterKind ->
                            M3e.FilterChipSet.component

                        InputKind ->
                            M3e.InputChipSet.component

                        _ ->
                            M3e.ChipSet.component

                Nothing ->
                    M3e.ChipSet.component
    in
    wrapper baseAttrs (List.map view cfg.chips)
