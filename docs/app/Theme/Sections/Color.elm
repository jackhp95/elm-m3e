module Theme.Sections.Color exposing (view)

{-| The Color accordion section (§8): one extra-small BUTTON per color token,
grouped by `Theme.Tokens.colorGroups` (37 tokens across 9 groups), laid out as a
wrapping cluster. Each button (a leading color-circle swatch + the role label)
hosts an `m3e-menu-trigger` that opens an anchored `m3e-menu` holding the
value-entry controls: a hex text input, an OS color picker, and Unset.

State lives only in the existing `colorOverrides` dict — a SET token shows the
`tonal` button variant and its literal override hex in the swatch; an UNSET token
shows the `outlined` variant and a neutral placeholder (transparent fill; Elm
cannot read the live computed CSS var, per the `Shared.elm` constraint). No new
`Theme.Model` field, no persisted-state change.

Uses the real `m3e-menu` family (replacing the earlier `<details>` fallback):
the anchor is `MenuTrigger.for` pointing at the sibling `M3e.menu`'s `id` — the
menu carries no `for`/`open` attribute. The menu's DEFAULT SLOT is typed to admit
only menu-item-family kinds, so the free-form entry panel (hex input + OS picker)
is routed in through `M3e.Unsafe.recast` — the same sanctioned escape hatch
`Shared.sectionPanel` uses to wrap already-built content into a slot it wasn't
originally typed for. The `m3e-menu` renders the slotted panel at runtime; the
Unset action stays a real `M3e.menuItem`.

-}

import Dict
import M3e exposing (Element)
import M3e.Action
import M3e.Attributes
import M3e.Component.Icon
import M3e.Component.MenuItem
import M3e.Unsafe
import M3e.Values as Value
import Theme exposing (Msg(..))
import Theme.Tokens as Tokens exposing (ColorToken)
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes
import TypedHtml.Events
import TypedHtml.Grouping
import TypedHtml.Sectioning


view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        (List.map (groupView model) Tokens.colorGroups)


groupView : Theme.Model -> ( String, List ColorToken ) -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
groupView model ( groupName, tokens ) =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1" ]
        [ TypedHtml.Sectioning.h3 [ TypedHtml.Attributes.class "text-on-surface-variant text-sm" ] [ M3e.text groupName ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-wrap gap-2" ]
            (List.map (tokenButton model) tokens)
        ]


{-| One color token: an extra-small button whose `m3e-menu-trigger` opens the
sibling value-entry `m3e-menu`.
-}
tokenButton : Theme.Model -> ColorToken -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
tokenButton model token =
    let
        current : Maybe String
        current =
            Dict.get token.cssVar model.colorOverrides

        isSet : Bool
        isSet =
            current /= Nothing

        menuId : String
        menuId =
            "colormenu-" ++ token.cssVar

        pickerId : String
        pickerId =
            "colorpick-" ++ token.cssVar

        -- Leading color swatch, routed to the button's `icon` slot (NOT nested in
        -- the display:none menu-trigger, which wouldn't project it). Neutral
        -- placeholder for an UNSET token: outline ring, transparent fill (Elm can't
        -- read the live computed var); a set token shows its literal override hex.
        swatch =
            TypedHtml.span
                [ TypedHtml.Attributes.slot "icon"
                , TypedHtml.Attributes.class "size-4 rounded-full border border-outline shrink-0"
                , TypedHtml.Attributes.style "background-color" (Maybe.withDefault "transparent" current)
                ]
                []

        -- Free-form entry controls; recast into the menu's typed slot below.
        entryPanel =
            TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1 p-2 min-w-48" ]
                [ TypedHtml.input
                    [ TypedHtml.Attributes.type_ "text"
                    , TypedHtml.Attributes.placeholder "#RRGGBB"
                    , TypedHtml.Attributes.value (Maybe.withDefault "" current)
                    , TypedHtml.Events.onInput (SetColorOverride token.cssVar)
                    , TypedHtml.Attributes.class "w-full rounded border border-outline bg-transparent px-2 py-1 text-on-surface"
                    , Aria.label ("Hex value for " ++ token.role)
                    ]
                    []
                , TypedHtml.label
                    [ TypedHtml.Attributes.for pickerId
                    , TypedHtml.Attributes.class "flex items-center gap-2 rounded px-2 py-1 cursor-pointer text-on-surface hover:bg-surface-container-high"
                    ]
                    [ M3e.icon [ M3e.Component.Icon.name "palette" ] []
                    , M3e.text "Pick from OS…"
                    , TypedHtml.input
                        [ TypedHtml.Attributes.id pickerId
                        , TypedHtml.Attributes.type_ "color"
                        , TypedHtml.Attributes.value (Maybe.withDefault "#000000" current)
                        , TypedHtml.Events.onInput (SetColorOverride token.cssVar)
                        , TypedHtml.Attributes.class "sr-only"
                        ]
                        []
                    ]
                ]
    in
    TypedHtml.div [ TypedHtml.Attributes.class "inline-block" ]
        [ M3e.button { content = M3e.Unsafe.recast swatch, action = M3e.Action.none }
            [ M3e.Attributes.size Value.extraSmall
            , M3e.Attributes.variant
                (if isSet then
                    Value.tonal

                 else
                    Value.outlined
                )
            ]
            [ M3e.menuTrigger { for = menuId }
                []
                [ M3e.text token.role ]
            ]
        , M3e.menu [ M3e.Attributes.id menuId ]
            [ M3e.Unsafe.recast entryPanel
            , M3e.menuItem
                [ M3e.Attributes.disabled (not isSet)
                , M3e.Component.MenuItem.onClick (ResetColorOverride token.cssVar)
                ]
                [ M3e.text "Unset" ]
            ]
        ]
