module M3e.Disclosure exposing
    ( Option
    , SectionOption
    , multi
    , section
    , sectionActions
    , sectionDisabled
    , sectionHideToggle
    , sectionOnToggle
    , sectionOpen
    , view
    )

{-| `<m3e-accordion>` + `<m3e-expansion-panel>` — click-to-expand collapsible
sections (Material 3 Disclosure / Accordion).

Spec (per docs/CONVENTIONS.md):

  - One section sub-component:
    `section : { header : String, content : List (Renderable any msg) }
    → List SectionOption → Renderable { section }`
  - View:
    `view : { sections : List (Renderable { section }) }
    → List Option → Renderable { disclosure }`
  - Slots: header (<span slot="header"> wrapping the title String)
    default (content region — free row, may include html escape)
    actions (<div slot="actions"> wrapping action buttons)
  - Properties: open, disabled, hide-toggle (section)
    multi (accordion)
  - Events: opened/closed → sectionOnToggle (Bool -> msg)
  - Tags: section → m3e-expansion-panel; view → m3e-accordion

**Simplification vs Ui.Disclosure** — Ui.Disclosure had two constructor paths
(`single` / `accordion`) and doubled modifier families for single panels vs
sections. Here there is ONE concept: a `section`. The `view` always renders an
`<m3e-accordion>` — for a single collapsible block simply pass one section.
This is cleaner and avoids the confusing split API.

-}

import Cem.M3e.Accordion as CemAccordion
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type alias SectionOption msg =
    Internal.Option (SectionConfig msg) msg


type alias Option msg =
    Internal.Option AccordionConfig msg


{-| Whether the section is initially expanded. Default false.
-}
sectionOpen : Bool -> SectionOption msg
sectionOpen b =
    Internal.option (\c -> { c | open = b })


{-| Disable the section (cannot be toggled by the user). Default false.
-}
sectionDisabled : Bool -> SectionOption msg
sectionDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Hide the expansion toggle icon. Default false.
-}
sectionHideToggle : Bool -> SectionOption msg
sectionHideToggle b =
    Internal.option (\c -> { c | hideToggle = b })


{-| Observe the section's open/close state. The handler receives `True` when
the panel reports `opened` and `False` when it reports `closed`.
-}
sectionOnToggle : (Bool -> msg) -> SectionOption msg
sectionOnToggle h =
    Internal.option (\c -> { c | onToggle = Just h })


{-| Action buttons shown in the section's `actions` slot.
-}
sectionActions : List (Renderable { button : Supported } msg) -> SectionOption msg
sectionActions xs =
    Internal.option (\c -> { c | actions = xs })


{-| Allow more than one section to be open at once (`multi` DOM property).
Default false (only one section open at a time).
-}
multi : Bool -> Option msg
multi b =
    Internal.option (\c -> { c | multi = b })


type alias SectionConfig msg =
    { open : Bool
    , disabled : Bool
    , hideToggle : Bool
    , onToggle : Maybe (Bool -> msg)
    , actions : List (Renderable { button : Supported } msg)
    }


defaultSectionConfig : SectionConfig msg
defaultSectionConfig =
    { open = False
    , disabled = False
    , hideToggle = False
    , onToggle = Nothing
    , actions = []
    }


{-| Construct a collapsible section (renders as `<m3e-expansion-panel>`).

    M3e.Disclosure.section
        { header = "Return policy"
        , content = [ M3e.Text.bodyMedium "Returns accepted within 30 days." ]
        }
        [ M3e.Disclosure.sectionOpen True
        , M3e.Disclosure.sectionOnToggle ReturnPolicyToggled
        ]

The `header` string is wrapped in `<span slot="header">`. Content lands in
the default slot. Action buttons go in the `actions` slot.

-}
section :
    { header : String, content : List (Renderable any msg) }
    -> List (SectionOption msg)
    -> Renderable { s | section : Supported } msg
section req opts =
    let
        c =
            Internal.applyOptions opts defaultSectionConfig
    in
    Internal.fromNode
        (Node.element "m3e-expansion-panel"
            (List.filterMap identity
                [ Just (Node.property "open" (Encode.bool c.open))
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , if c.hideToggle then
                    Just (Node.property "hide-toggle" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\h -> Node.on "opened" (Decode.succeed (h True))) c.onToggle
                , Maybe.map (\h -> Node.on "closed" (Decode.succeed (h False))) c.onToggle
                ]
            )
            (List.concat
                [ [ Node.element "span"
                        [ Node.attribute "slot" "header" ]
                        [ Node.text req.header ]
                  ]
                , List.map Renderable.toNode req.content
                , case c.actions of
                    [] ->
                        []

                    xs ->
                        [ Node.element "div"
                            [ Node.attribute "slot" "actions" ]
                            (List.map Renderable.toNode xs)
                        ]
                ]
            )
        )



-- Accordion (view)


type alias AccordionConfig =
    { multi : Bool }


defaultAccordionConfig : AccordionConfig
defaultAccordionConfig =
    { multi = False }


{-| Render the accordion wrapping the provided sections.

    M3e.Disclosure.view
        { sections =
            [ M3e.Disclosure.section { header = "Profile", content = [ profileForm ] } []
            , M3e.Disclosure.section { header = "Billing", content = [ billingForm ] } []
            ]
        }
        []

For a single collapsible block, pass a list with one section. The `multi`
option allows more than one section to be open simultaneously.

-}
view :
    { sections : List (Renderable { section : Supported } msg) }
    -> List (Option msg)
    -> Renderable { s | disclosure : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaultAccordionConfig
    in
    Internal.fromNode
        (Node.element "m3e-accordion"
            (List.filterMap identity
                [ if c.multi then
                    Just (Node.rawAttr (CemAccordion.multi True))

                  else
                    Nothing
                ]
            )
            (List.map Renderable.toNode req.sections)
        )
