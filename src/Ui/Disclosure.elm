module Ui.Disclosure exposing
    ( Disclosure
    , single, accordion
    , Section, section
    , withAttributes
    , withOpen, withDisabled, withOnToggle, withHideToggle
    , withPanelActions, withToggleIcon
    , withSectionOpen, withSectionOnToggle
    , withSectionActions, withSectionToggleIcon
    , withMulti
    , view
    )

{-| Typed builder for click-to-expand surfaces. The underlying element is
chosen **at the call site** by which constructor you reach for — never
inferred from how many panels you happen to pass (that would be render-path
inference, a D4 violation):

  - [`single`](#single) → one `m3e-expansion-panel` (a single collapsible
    surface — an FAQ entry, a "show more" detail block).
  - [`accordion`](#accordion) → an `m3e-accordion` wrapping one
    `m3e-expansion-panel` per [`Section`](#Section). By default only one
    panel opens at a time; opt into simultaneous expansion with
    [`withMulti`](#withMulti).

Both constructors require an explicit, caller-supplied id (Section likewise).
There is no shared default id — two disclosures never collide.

The header content lands in each panel's `header` slot (per the CEM); the body
content lands in the panel's default slot.


# Type

@docs Disclosure


# Constructors

@docs single, accordion


# Sections (for accordions)

@docs Section, section


# Host attributes

@docs withAttributes


# Single-panel configuration

@docs withOpen, withDisabled, withOnToggle, withHideToggle
@docs withPanelActions, withToggleIcon


# Per-section configuration

@docs withSectionOpen, withSectionOnToggle
@docs withSectionActions, withSectionToggleIcon


# Accordion configuration

@docs withMulti


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Accordion
import M3e.ExpansionPanel
import Ui.Icon


{-| A configured disclosure. Build one with [`single`](#single) or
[`accordion`](#accordion).
-}
type Disclosure msg
    = Single (Panel msg)
    | Accordion (AccordionConfig msg) (List (Section msg))


{-| One collapsible surface inside an accordion. Build with
[`section`](#section).
-}
type Section msg
    = Section (Panel msg)


type alias Panel msg =
    { id : String
    , attributes : List (Attribute msg)
    , headline : Html msg
    , content : List (Html msg)
    , open : Bool
    , disabled : Bool
    , hideToggle : Bool
    , onToggle : Maybe (Bool -> msg)
    , actions : List (Html msg)
    , toggleIcon : Maybe (Ui.Icon.Icon msg)
    }


type alias AccordionConfig msg =
    { id : String
    , attributes : List (Attribute msg)
    , multi : Bool
    }



-- CONSTRUCTORS


{-| A single collapsible panel, rendered as `m3e-expansion-panel`.

    Disclosure.single "faq-returns"
        (Html.text "What is your return policy?")
        [ Html.text "Returns accepted within 30 days." ]
        |> Disclosure.view

The id is required and applied to the panel element; the headline goes to the
`header` slot and the content to the default slot.

-}
single : String -> Html msg -> List (Html msg) -> Disclosure msg
single id_ headline content =
    Single (newPanel id_ headline content)


{-| A group of collapsible panels, rendered as `m3e-accordion`. Each
[`Section`](#section) becomes one `m3e-expansion-panel` child.

    Disclosure.accordion "settings"
        [ Disclosure.section "settings-profile"
            (Html.text "Profile")
            [ profileForm ]
        , Disclosure.section "settings-billing"
            (Html.text "Billing")
            [ billingForm ]
        ]
        |> Disclosure.view

Defaults to single-open (`multi=false`, the CEM default); opt into
simultaneous expansion with [`withMulti`](#withMulti).

-}
accordion : String -> List (Section msg) -> Disclosure msg
accordion id_ sections =
    Accordion { id = id_, attributes = [], multi = False } sections


{-| A panel inside an accordion. The id is required and distinct from the
accordion's id, so panels never collide.
-}
section : String -> Html msg -> List (Html msg) -> Section msg
section id_ headline content =
    Section (newPanel id_ headline content)


newPanel : String -> Html msg -> List (Html msg) -> Panel msg
newPanel id_ headline content =
    { id = id_
    , attributes = []
    , headline = headline
    , content = content
    , open = False
    , disabled = False
    , hideToggle = False
    , onToggle = Nothing
    , actions = []
    , toggleIcon = Nothing
    }



-- HOST ATTRIBUTES


{-| Append attributes to the rendered root host — the `<m3e-expansion-panel>`
of a [`single`](#single) disclosure, or the `<m3e-accordion>` wrapper of an
[`accordion`](#accordion). Structural attributes are emitted after these, so
callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Disclosure msg -> Disclosure msg
withAttributes attributes disclosure =
    case disclosure of
        Single p ->
            Single { p | attributes = p.attributes ++ attributes }

        Accordion cfg sections ->
            Accordion { cfg | attributes = cfg.attributes ++ attributes } sections



-- PANEL CONFIGURATION


{-| Render a `single` disclosure's panel initially expanded. No-op on an
`accordion` — drive its panels per-section with [`withSectionOpen`](#withSectionOpen).
-}
withOpen : Bool -> Disclosure msg -> Disclosure msg
withOpen flag =
    mapSinglePanel (\p -> { p | open = flag })


{-| Disable the panel: it cannot be toggled by the user.
-}
withDisabled : Bool -> Disclosure msg -> Disclosure msg
withDisabled flag =
    mapSinglePanel (\p -> { p | disabled = flag })


{-| Hide the panel's expansion toggle icon.
-}
withHideToggle : Bool -> Disclosure msg -> Disclosure msg
withHideToggle flag =
    mapSinglePanel (\p -> { p | hideToggle = flag })


{-| Caller-owned open state. The handler fires with `True` when the panel
reports `opened` and `False` when it reports `closed`.
-}
withOnToggle : (Bool -> msg) -> Disclosure msg -> Disclosure msg
withOnToggle handler =
    mapSinglePanel (\p -> { p | onToggle = Just handler })


{-| Fill a `single` panel's `actions` slot with arbitrary content (e.g.
buttons shown in the panel's action row). No-op on an `accordion` — drive
its panels per-section with [`withSectionActions`](#withSectionActions).
-}
withPanelActions : List (Html msg) -> Disclosure msg -> Disclosure msg
withPanelActions actions =
    mapSinglePanel (\p -> { p | actions = actions })


{-| Provide a custom `toggle-icon` for a `single` panel's expansion control.
No-op on an `accordion` — use [`withSectionToggleIcon`](#withSectionToggleIcon).
-}
withToggleIcon : Ui.Icon.Icon msg -> Disclosure msg -> Disclosure msg
withToggleIcon icon =
    mapSinglePanel (\p -> { p | toggleIcon = Just icon })


mapSinglePanel : (Panel msg -> Panel msg) -> Disclosure msg -> Disclosure msg
mapSinglePanel f disclosure =
    case disclosure of
        Single p ->
            Single (f p)

        Accordion _ _ ->
            disclosure



-- SECTION CONFIGURATION


{-| Render a section initially expanded.
-}
withSectionOpen : Bool -> Section msg -> Section msg
withSectionOpen flag (Section p) =
    Section { p | open = flag }


{-| Caller-owned open state for a section.
-}
withSectionOnToggle : (Bool -> msg) -> Section msg -> Section msg
withSectionOnToggle handler (Section p) =
    Section { p | onToggle = Just handler }


{-| Fill a section panel's `actions` slot with arbitrary content.
-}
withSectionActions : List (Html msg) -> Section msg -> Section msg
withSectionActions actions (Section p) =
    Section { p | actions = actions }


{-| Provide a custom `toggle-icon` for a section panel's expansion control.
-}
withSectionToggleIcon : Ui.Icon.Icon msg -> Section msg -> Section msg
withSectionToggleIcon icon (Section p) =
    Section { p | toggleIcon = Just icon }



-- ACCORDION CONFIGURATION


{-| Allow more than one panel of an accordion to be open at once
(`multi=true`). No-op on a `single` disclosure.
-}
withMulti : Bool -> Disclosure msg -> Disclosure msg
withMulti flag disclosure =
    case disclosure of
        Accordion cfg sections ->
            Accordion { cfg | multi = flag } sections

        Single _ ->
            disclosure



-- RENDER


{-| Render the disclosure to `Html`.
-}
view : Disclosure msg -> Html msg
view disclosure =
    case disclosure of
        Single p ->
            viewPanel p

        Accordion cfg sections ->
            M3e.Accordion.component
                (cfg.attributes
                    ++ [ Attr.id cfg.id
                       , M3e.Accordion.multi cfg.multi
                       ]
                )
                (List.map (\(Section p) -> viewPanel p) sections)


viewPanel : Panel msg -> Html msg
viewPanel p =
    M3e.ExpansionPanel.component
        (p.attributes ++ Attr.id p.id :: panelAttrs p)
        (List.concat
            [ [ Html.span [ M3e.ExpansionPanel.headerSlot ] [ p.headline ] ]
            , toggleIconElement p.toggleIcon
            , p.content
            , actionsElement p.actions
            ]
        )


toggleIconElement : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
toggleIconElement toggleIcon =
    case toggleIcon of
        Nothing ->
            []

        Just icon ->
            [ Html.span
                [ M3e.ExpansionPanel.toggleIconSlot
                , Attr.attribute "aria-hidden" "true"
                ]
                [ Ui.Icon.view icon ]
            ]


actionsElement : List (Html msg) -> List (Html msg)
actionsElement actions =
    case actions of
        [] ->
            []

        _ ->
            [ Html.div [ M3e.ExpansionPanel.actionsSlot ] actions ]


panelAttrs : Panel msg -> List (Html.Attribute msg)
panelAttrs p =
    List.filterMap identity
        [ boolAttr M3e.ExpansionPanel.open p.open
        , boolAttr M3e.ExpansionPanel.disabled p.disabled
        , boolAttr M3e.ExpansionPanel.hideToggle p.hideToggle
        , Maybe.map (\h -> M3e.ExpansionPanel.onOpened (Decode.succeed (h True))) p.onToggle
        , Maybe.map (\h -> M3e.ExpansionPanel.onClosed (Decode.succeed (h False))) p.onToggle
        ]


boolAttr : (Bool -> Html.Attribute msg) -> Bool -> Maybe (Html.Attribute msg)
boolAttr toAttr flag =
    if flag then
        Just (toAttr True)

    else
        Nothing
