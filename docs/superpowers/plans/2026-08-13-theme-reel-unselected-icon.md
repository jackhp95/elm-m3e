# Plan — Theme Reel: unselected-card icon (no reflow)

**Goal:** Every preset card in `Theme.Reel` renders an icon in the same position
always. Unselected → `radio_button_unchecked` (outline ring, `text-on-surface-variant`).
Selected → `check_circle` (filled, `text-primary`). No vertical reflow on selection change.

**Architecture:** Single-function change in `docs/app/Theme/Reel.elm`.
`selectedBadge` (conditional, selected only) is replaced by `cardBadge isActive`
(unconditional). `cardBody` passes `isActive` straight through — the rest of the
module is untouched.

**Tech Stack:** Elm · M3e icon API (`M3e.icon`, `M3e.Component.Icon.name`,
`M3e.Component.Icon.filled`) · Tailwind colour utilities · elm-format · elm-pages.

**Expected model tier:** haiku / low (single function, no design ambiguity).

---

## Steps

### 1 · Edit `cardBody` — remove conditional, call `cardBadge` unconditionally

**File:** `docs/app/Theme/Reel.elm` lines 143–158

Before:
```elm
cardBody : Bool -> Preset -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardBody isActive preset =
    TypedHtml.div
        [ TA.class "flex flex-col gap-1.5" ]
        (List.concat
            [ if isActive then
                [ selectedBadge ]

              else
                []
            , [ cardName preset
              , cardSpecimen preset
              , cardRoleStrip
              ]
            ]
        )
```

After:
```elm
cardBody : Bool -> Preset -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardBody isActive preset =
    TypedHtml.div
        [ TA.class "flex flex-col gap-1.5" ]
        [ cardBadge isActive
        , cardName preset
        , cardSpecimen preset
        , cardRoleStrip
        ]
```

Note: `List.concat` is no longer needed; the list is now a plain literal.

---

### 2 · Replace `selectedBadge` with `cardBadge`

**File:** `docs/app/Theme/Reel.elm` lines 161–175

Remove `selectedBadge` entirely and add `cardBadge` in its place:

Before:
```elm
{-| The "selected" affordance: a filled `check_circle` icon, right-aligned.
Shown only for the active card. Its colour inherits `on-surface` from the
card's own nested theme.
-}
selectedBadge : Element (TypedHtml.Grouping.DivIs s) admittedBy msg
selectedBadge =
    TypedHtml.div
        [ TA.class "flex justify-end -mb-1 text-primary" ]
        [ M3e.icon
            [ M3e.Component.Icon.name "check_circle"
            , M3e.Component.Icon.filled True
            , MA.class "text-base"
            ]
            []
        ]
```

After:
```elm
{-| Selection affordance: always rendered so the badge row never collapses.
Active card → filled `check_circle` in primary; inactive → outline ring
(`radio_button_unchecked`) in a neutral/dim tone so it recedes visually.
Both icons occupy the same slot so no reflow occurs on selection change.
-}
cardBadge : Bool -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardBadge isActive =
    TypedHtml.div
        [ TA.class "flex justify-end -mb-1" ]
        [ if isActive then
            M3e.icon
                [ M3e.Component.Icon.name "check_circle"
                , M3e.Component.Icon.filled True
                , MA.class "text-base text-primary"
                ]
                []

          else
            M3e.icon
                [ M3e.Component.Icon.name "radio_button_unchecked"
                , MA.class "text-base text-on-surface-variant"
                ]
                []
        ]
```

Key choices:
- `text-primary` moved from the wrapper div into each icon's own class list
  (the wrapper is now colour-neutral, both branches own their colour).
- `radio_button_unchecked` is inherently outline — no `filled` attribute needed.
- `text-on-surface-variant` matches the spec's "dim/neutral" requirement without
  hardcoding any hex.

---

### 3 · elm-format

```bash
docs/node_modules/.bin/elm-format docs/app/Theme/Reel.elm --yes
```

Verify the file compiles cleanly before proceeding.

---

### 4 · Build

```bash
cd /Users/jack/Documents/code/elm-m3e/docs && npm run build:site
```

Confirm zero Elm compile errors and the build succeeds.

---

### 5 · Manual visual verification

Start the production build server (port 1239 / the gate) or open `docs/dist/` in a
browser. Navigate to any page that shows the Theme Reel (Getting Started → Welcome,
or open the settings drawer).

Checklist:
- [ ] Every unselected card shows a faint outline ring at the same top-right position
      where the check_circle appears on the selected card.
- [ ] Clicking each preset card in sequence: no vertical shift in name, "Aa" specimen,
      or role-strip as the icon swaps between states.
- [ ] Selected card: `check_circle` filled, clearly primary-coloured.
- [ ] Unselected cards: `radio_button_unchecked`, visually dim/neutral (not green,
      not primary).

---

## Non-goals (do not touch)

- Card selection logic (`isActive`, `config.activeId`, `config.onPick`).
- `aria-pressed` / `aria-label` attributes.
- Elevated/outlined variant swap (lines 119–123).
- `cardName`, `cardSpecimen`, `cardRoleStrip`, `roleAvatar` — no changes.
- Any other file in the repo.
