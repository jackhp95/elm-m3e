module Ui.Chip exposing
    ( Chip, Filter, Input, Generic
    , assist, suggestion, filter, input
    , assistEscapeHatchHtml, suggestionEscapeHatchHtml, filterEscapeHatchHtml, inputEscapeHatchHtml
    , withAttributes
    , withSelected, withDisabled, withElevated, withIcon, withHref
    , view
    , Set, filterSet, inputSet, genericSet, withId, withChip, withChips
    , withSetAttributes
    , viewSet
    )

{-| Typed builder for the `<m3e-*-chip>` family — compact, often dynamic choices.
Reach for chips over a checkbox/radio/select when the options are tag-like or
generated on the fly: filter chips for multi-select filtering, input chips for
tokenized entry, and suggestion/assist chips for prompts. The four M3 chip kinds
are separate constructors that take their required collaborators up front, so a
chip can't be built without the behavior its kind demands, and a modifier that
only makes sense for one kind can't be applied to another.

The phantom `kind` parameter (`Filter` / `Input` / `Generic`) gates the
kind-specific modifiers and the typed sets:

  - [`assist`](#assist) / [`suggestion`](#suggestion) → `Chip Generic msg`:
    button-like smart/automated actions and dynamically-generated suggestions.
    Both accept [`withHref`](#withHref) (link behavior) and live in the generic
    chip set.
  - [`filter`](#filter) → `Chip Filter msg`: a select/deselect toggle. Accepts
    [`withSelected`](#withSelected); lives only in a filter set.
  - [`input`](#input) → `Chip Input msg`: represents a discrete value the user
    entered, with a required trailing remove; lives only in an input set.

Color is token-driven, not per-instance (M3 has no "colorable chip"); the only
visual axis is outlined (default) vs [`withElevated`](#withElevated), per spec.


# Chip construction

@docs Chip, Filter, Input, Generic
@docs assist, suggestion, filter, input
@docs assistEscapeHatchHtml, suggestionEscapeHatchHtml, filterEscapeHatchHtml, inputEscapeHatchHtml


# Host attributes

@docs withAttributes


# Chip modifiers

@docs withSelected, withDisabled, withElevated, withIcon, withHref


# Render

@docs view


# Chip set

A set holds chips of a single kind — a filter set holds only filter chips, an
input set only input chips — so a heterogeneous set (which the M3e wrappers
can't represent) is a compile error rather than a silent downgrade.

@docs Set, filterSet, inputSet, genericSet, withId, withChip, withChips
@docs withSetAttributes


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

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import Cem.M3e.AssistChip
import Cem.M3e.Chip
import Cem.M3e.ChipSet
import Cem.M3e.FilterChip
import Cem.M3e.FilterChipSet
import Cem.M3e.InputChip
import Cem.M3e.InputChipSet
import Cem.M3e.SuggestionChip
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
    , attributes : List (Attribute msg)
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
    , attributes = []
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


{-| A button-like assist chip — for a smart or automated action (which may span
multiple apps). Renders `<m3e-assist-chip>`.
-}
assist : { id : String, label : String, onClick : msg } -> Chip Generic msg
assist { id, label, onClick } =
    assistEscapeHatchHtml { id = id, label = Html.text label, onClick = onClick }


{-| Escape hatch: `assist` with an arbitrary-`Html` label (e.g. icon + text).
-}
assistEscapeHatchHtml : { id : String, label : Html msg, onClick : msg } -> Chip Generic msg
assistEscapeHatchHtml { id, label, onClick } =
    let
        base : ChipConfig msg
        base =
            defaultChip id Assist label
    in
    Chip { base | onClick = Just onClick }


{-| A suggestion chip — a dynamically-generated action presented to narrow the
user's intent. Renders `<m3e-suggestion-chip>`.
-}
suggestion : { id : String, label : String, onClick : msg } -> Chip Generic msg
suggestion { id, label, onClick } =
    suggestionEscapeHatchHtml { id = id, label = Html.text label, onClick = onClick }


{-| Escape hatch: `suggestion` with an arbitrary-`Html` label.
-}
suggestionEscapeHatchHtml : { id : String, label : Html msg, onClick : msg } -> Chip Generic msg
suggestionEscapeHatchHtml { id, label, onClick } =
    let
        base : ChipConfig msg
        base =
            defaultChip id Suggestion label
    in
    Chip { base | onClick = Just onClick }


{-| A filter chip — a select/deselect toggle for filtering. Renders
`<m3e-filter-chip>` (`selected` defaults to false). Pair with
[`withSelected`](#withSelected) to drive the selected state.
-}
filter : { id : String, label : String, onToggle : msg } -> Chip Filter msg
filter { id, label, onToggle } =
    filterEscapeHatchHtml { id = id, label = Html.text label, onToggle = onToggle }


{-| Escape hatch: `filter` with an arbitrary-`Html` label.
-}
filterEscapeHatchHtml : { id : String, label : Html msg, onToggle : msg } -> Chip Filter msg
filterEscapeHatchHtml { id, label, onToggle } =
    let
        base : ChipConfig msg
        base =
            defaultChip id FilterKind label
    in
    Chip { base | onToggle = Just onToggle }


{-| An input chip representing a discrete value the user entered. Renders
`<m3e-input-chip removable>` — the trailing remove affordance is required per
spec, so `onRemove` is a constructor argument.
-}
input : { id : String, label : String, onRemove : msg } -> Chip Input msg
input { id, label, onRemove } =
    inputEscapeHatchHtml { id = id, label = Html.text label, onRemove = onRemove }


{-| Escape hatch: `input` chip with an arbitrary-`Html` label.
-}
inputEscapeHatchHtml : { id : String, label : Html msg, onRemove : msg } -> Chip Input msg
inputEscapeHatchHtml { id, label, onRemove } =
    let
        base : ChipConfig msg
        base =
            defaultChip id InputKind label
    in
    Chip { base | onRemove = Just onRemove }


{-| Append attributes to the per-kind chip element (`<m3e-assist-chip>`,
`<m3e-suggestion-chip>`, `<m3e-filter-chip>`, or `<m3e-input-chip>`). Structural
attributes are emitted after these, so callers can't clobber them. For a chip
_set_, style the wrapper with [`withSetAttributes`](#withSetAttributes).
-}
withAttributes : List (Attribute msg) -> Chip kind msg -> Chip kind msg
withAttributes attributes (Chip cfg) =
    Chip { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the filter chip's `selected` state (sets `selected` on
`<m3e-filter-chip>`; default false). Filter-only.

@figma-code-connect prop=Selected bool component=Filter

-}
withSelected : Bool -> Chip Filter msg -> Chip Filter msg
withSelected flag (Chip cfg) =
    Chip { cfg | selected = flag }


{-| Disable a chip — non-interactive (sets `disabled`; default false). Valid on
every kind.

@figma-code-connect prop=Disabled bool component=Assist,Filter,Suggestion,Input

-}
withDisabled : Bool -> Chip kind msg -> Chip kind msg
withDisabled flag (Chip cfg) =
    Chip { cfg | disabled = flag }


{-| Use the elevated style instead of the default outlined style (sets
`variant`, default "outlined"). M3 reserves elevated chips for image/busy
backgrounds.
-}
withElevated : Bool -> Chip kind msg -> Chip kind msg
withElevated flag (Chip cfg) =
    Chip { cfg | elevated = flag }


{-| Add a leading icon, rendered into the chip's `icon` slot (before the label).
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


{-| A filter set — holds only [`filter`](#filter) chips and renders into a
`FilterChipSet` wrapper, regardless of contents (an empty filter set still
renders the filter wrapper).
-}
filterSet : List (Chip Filter msg) -> Set Filter msg
filterSet chips =
    Set { id = Nothing, attributes = [], chips = chips, wrapper = Cem.M3e.FilterChipSet.component }


{-| An input set — holds only [`input`](#input) chips and renders into an
`InputChipSet` wrapper, regardless of contents.
-}
inputSet : List (Chip Input msg) -> Set Input msg
inputSet chips =
    Set { id = Nothing, attributes = [], chips = chips, wrapper = Cem.M3e.InputChipSet.component }


{-| A generic set for [`assist`](#assist) / [`suggestion`](#suggestion) chips,
rendered into the basic `ChipSet` wrapper.
-}
genericSet : List (Chip Generic msg) -> Set Generic msg
genericSet chips =
    Set { id = Nothing, attributes = [], chips = chips, wrapper = Cem.M3e.ChipSet.component }


{-| A typed chip set. Build via `filterSet`, `inputSet`, or `genericSet`.
-}
type Set kind msg
    = Set (SetConfig kind msg)


type alias SetConfig kind msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , chips : List (Chip kind msg)
    , wrapper : List (Html.Attribute msg) -> List (Html msg) -> Html msg
    }


{-| Set the chip set's `id` attribute.
-}
withId : String -> Set kind msg -> Set kind msg
withId id (Set cfg) =
    Set { cfg | id = Just id }


{-| Append attributes to the chip-set wrapper element
(`<m3e-filter-chip-set>` / `<m3e-input-chip-set>` / `<m3e-chip-set>`).
Structural attributes are emitted after these, so callers can't clobber them.
For a single chip, style its element with [`withAttributes`](#withAttributes).
-}
withSetAttributes : List (Attribute msg) -> Set kind msg -> Set kind msg
withSetAttributes attributes (Set cfg) =
    Set { cfg | attributes = cfg.attributes ++ attributes }


{-| Append a single chip to the set.
-}
withChip : Chip kind msg -> Set kind msg -> Set kind msg
withChip c (Set cfg) =
    Set { cfg | chips = cfg.chips ++ [ c ] }


{-| Append a list of chips to the set.
-}
withChips : List (Chip kind msg) -> Set kind msg -> Set kind msg
withChips cs (Set cfg) =
    Set { cfg | chips = cfg.chips ++ cs }


{-| Render a chip on its own (outside a set).
-}
view : Chip kind msg -> Html msg
view (Chip cfg) =
    let
        iconChildren : List (Html msg)
        iconChildren =
            case cfg.icon of
                Just i ->
                    [ Html.span [ Cem.M3e.Chip.iconSlot ] [ Ui.Icon.view i ] ]

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
            Cem.M3e.AssistChip.component
                (cfg.attributes
                    ++ List.filterMap identity
                        [ Just (Attr.id cfg.id)
                        , Just (genericStyle cfg.elevated (Cem.M3e.AssistChip.variant Cem.M3e.AssistChip.Elevated) (Cem.M3e.AssistChip.variant Cem.M3e.AssistChip.Outlined))
                        , Just (Cem.M3e.AssistChip.disabled cfg.disabled)
                        , linkOrClick Cem.M3e.AssistChip.href (on Cem.M3e.AssistChip.onClick) cfg
                        ]
                )
                children

        Suggestion ->
            Cem.M3e.SuggestionChip.component
                (cfg.attributes
                    ++ List.filterMap identity
                        [ Just (Attr.id cfg.id)
                        , Just (genericStyle cfg.elevated (Cem.M3e.SuggestionChip.variant Cem.M3e.SuggestionChip.Elevated) (Cem.M3e.SuggestionChip.variant Cem.M3e.SuggestionChip.Outlined))
                        , Just (Cem.M3e.SuggestionChip.disabled cfg.disabled)
                        , linkOrClick Cem.M3e.SuggestionChip.href (on Cem.M3e.SuggestionChip.onClick) cfg
                        ]
                )
                children

        FilterKind ->
            Cem.M3e.FilterChip.component
                (cfg.attributes
                    ++ List.filterMap identity
                        [ Just (Attr.id cfg.id)
                        , Just (genericStyle cfg.elevated (Cem.M3e.FilterChip.variant Cem.M3e.FilterChip.Elevated) (Cem.M3e.FilterChip.variant Cem.M3e.FilterChip.Outlined))
                        , Just (Cem.M3e.FilterChip.selected cfg.selected)
                        , Just (Cem.M3e.FilterChip.disabled cfg.disabled)
                        , Maybe.map (on Cem.M3e.FilterChip.onChange) cfg.onToggle
                        ]
                )
                children

        InputKind ->
            Cem.M3e.InputChip.component
                (cfg.attributes
                    ++ List.filterMap identity
                        [ Just (Attr.id cfg.id)
                        , Just (genericStyle cfg.elevated (Cem.M3e.InputChip.variant Cem.M3e.InputChip.Elevated) (Cem.M3e.InputChip.variant Cem.M3e.InputChip.Outlined))
                        , Just (Cem.M3e.InputChip.removable True)
                        , Just (Cem.M3e.InputChip.disabled cfg.disabled)
                        , Maybe.map (on Cem.M3e.InputChip.onRemove) cfg.onRemove
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


{-| Render a chip set. The wrapper element was fixed by the set constructor
([`filterSet`](#filterSet) → `FilterChipSet`, [`inputSet`](#inputSet) →
`InputChipSet`, [`genericSet`](#genericSet) → `ChipSet`), so it's correct
regardless of contents — an empty set still renders its declared wrapper.
-}
viewSet : Set kind msg -> Html msg
viewSet (Set cfg) =
    let
        baseAttrs : List (Html.Attribute msg)
        baseAttrs =
            cfg.attributes ++ List.filterMap identity [ Maybe.map Attr.id cfg.id ]
    in
    cfg.wrapper baseAttrs (List.map view cfg.chips)
