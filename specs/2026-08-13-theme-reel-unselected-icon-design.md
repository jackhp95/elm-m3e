# Spec — Theme Reel: icon on unselected preset cards

Date: 2026-08-13
Repo: `elm-m3e`
Status: approved design, not yet planned
Related: `docs/app/Theme/Reel.elm`

## Problem

`Theme.Reel` (the horizontal scroll row of preset theme cards, `docs/app/Theme/Reel.elm`)
only renders an icon (`check_circle`, filled, primary color) on the **active** card
(lines 148-150, 165-175). Unselected cards render no icon at all. Selecting a
different card therefore shifts each card's content vertically by the icon's height —
a visible layout jump on every selection.

## Non-goals

- No change to card selection logic, `isActive` computation, `aria-pressed`/
  `aria-label`, or the elevated/outlined variant swap (lines 119-123).
- No change to card content below the icon (name, "Aa" specimen, role-strip).

## Design

Every card renders an icon in the same slot, at the same position, always — only the
icon identity and color change with selection state:

- **Selected**: `check_circle`, filled, `text-primary` (unchanged from today).
- **Unselected**: an outline-style circle icon (Material Symbols' outlined
  `radio_button_unchecked`, or `circle` in the outlined variant — implementer's call
  between the two, whichever renders as a clean unfilled ring at the icon size already
  in use), rendered in a neutral/dim tone (`text-outline` or `text-on-surface-variant`
  — not primary, not green).

Both icons occupy the identical position (same right-aligned, top-offset slot the
`check_circle` badge uses today) so no reflow occurs when the active card changes.

## Testing

Visual/manual check: select each preset card in sequence, confirm no vertical shift in
any card's name/specimen/role-strip as the icon swaps between the two states.
