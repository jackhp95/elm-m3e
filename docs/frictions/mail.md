# Frictions — Mail example app

Honest, specific log of every point of friction hit while building the
`Route.Examples.Mail` email-client screen. Screen uses M3e components for all
chrome/content and Tailwind strictly for layout, with color/type/surface/shape
routed through the Kit seam.

## Tooling

1. **`build:assets` failed on a stale scratch dir (hard blocker, self-resolved).**
   The very first `npm run build:assets` crashed inside `build:reference` with an
   *internal Elm compiler error*:
   `docs.json: withBinaryFile: does not exist (No such file or directory)` /
   `elm make --docs failed in /tmp/m3e-docs-gen`. This is `scripts/extract-reference.mjs`
   compiling the whole `packages/m3e` package to `docs.json` in a shared
   `/tmp/m3e-docs-gen` scratch project. The scratch dir was left in a half-written
   state from a prior run in another worktree (shared `/tmp` path, not worktree-scoped).
   `rm -rf /tmp/m3e-docs-gen` and re-running fixed it. Cost a diagnosis cycle;
   the error text (an elm.org "please file a compiler bug" wall) actively pointed
   the wrong direction. **Gap:** the reference-build scratch path should be
   worktree/PID-scoped, not a fixed global `/tmp` dir, so parallel worktrees don't
   corrupt each other.

2. **`elm-pages gen` prints nothing on success.** No "done" line, no exit banner —
   just silence. Had to assert on `$?` and `ls .elm-pages/` to be sure it worked.
   Minor, but it makes "did setup actually succeed?" ambiguous in an agent loop.

3. **Model/Msg change forces a re-gen.** Making the screen stateful (a real `Msg`
   union instead of `()`) meant `.elm-pages/` codegen was stale until I re-ran
   `elm-pages gen`. Expected per the brief, but it's an easy footgun: elm-review
   compiles against the generated `Main.elm`, so a forgotten re-gen would surface
   as a confusing type error far from the actual edit.

## Library / component capability gaps

4. **`SearchBar` requires a raw `<input>` through the seam — no M3e text field.**
   `SearchBar.view` takes `{ input : Element any msg }` for its `input` slot, but
   there is no `M3e.TextField` / input component to fill it. I had to hand-roll
   `Native.node Html.input [...]` and push `placeholder`/`type` through
   `Seam.asAttribute`. So the ONE genuinely interactive control on the screen is
   the one place I'm forced back to raw HTML + the escape hatch. Feels like a hole
   in the component set for a search-first surface.

5. **`Avatar` has no built-in shape/size/color — it's just a slot.** `Avatar.view`
   is `attrs -> content`, with only a `slot` attr. To get the classic "initials on
   a colored disc" I had to nest a `Surface.view secondaryContainer` with
   `Shape.corner Shape.full` and Tailwind `h-10 w-10 flex items-center justify-center`
   *inside* the Avatar. The Avatar element itself contributes nothing visual here;
   it's a semantic wrapper. An `Avatar` that painted a default circle + centered its
   content would remove a whole layer of boilerplate (repeated once per row + reading pane).

6. **`ListItem` supporting text is a single slot, but a mail row wants two lines
   (subject + snippet) with different type scales.** `ListItem.supportingText`
   takes one `Element`. To show subject (body-md, on-surface) over snippet
   (body-sm, on-surface-variant) I stuffed two stacked `Native.span "block"`
   wrappers into that one slot. It renders correctly, but it's using a layout
   `<span class="block">` to fake a two-line supporting region the component
   doesn't model. A multi-line / secondary+tertiary supporting API would be cleaner.

7. **No "selected" affordance on `ListItem`.** To mark the open message I wrapped
   each row in a `Surface.view` (surfaceContainer vs surface) and put the click
   handler + `role="button"` on that wrapper. `ListItem` itself has no
   selected/active state and isn't clickable (there's a separate `ListItemButton`,
   but it doesn't compose with the leading/supporting/trailing slot set the way a
   selectable mail row needs). Result: the interactive, stateful element is a
   hand-rolled Surface wrapper, not the list item.

8. **`AssistChip` requires an `action` even when the label is decorative.** Labels
   in the reading pane are just tags, but `AssistChip.view` mandates
   `{ content, action }`. I passed `Action.link "#"` to satisfy the type. A
   non-interactive chip variant (or making `action` optional) would fit "display a
   label" better. (`M3e.Chip` exists but is value/selection-flavored; `AssistChip`
   read as the closest "labeled pill".)

## Pull toward Tailwind for styling (resisted)

9. **The whole two-pane reflow is Tailwind, because no M3e layout primitive covers
   it.** There's `M3e.SplitPane` / `M3e.ContentPane`, but they don't express the
   *responsive collapse* the brief demands (side-by-side at `md:`, stacked below).
   So the core layout is `flex flex-col md:flex-row` with `md:w-96 md:shrink-0` on
   the list and `flex-1` on the reading pane — all layout, which is allowed, but it
   means the signature interaction of the screen owes nothing to the component
   library. `md:border-r md:border-outline-variant` is the one spot that's arguably
   borderline (a border), but `outline-variant` is an M3 token and it's purely the
   pane seam, matching how `Surface.outlined` is defined.

10. **FAB placement + "stay above the mobile bar" is hand-tuned Tailwind magic
    numbers.** `absolute bottom-20 right-6 md:bottom-6` — the `bottom-20` is a
    guess at the NavBar height so the FAB clears it on mobile. There's no layout
    relationship between `NavBar` and `Fab`; I'm eyeballing pixels. A docked-FAB or
    scaffold that knew about the bottom bar's height would remove the magic number.

## elm-review fights

11. **`NoMissingTypeAnnotationInLetIn` on the row-surface `let`.** Annotating a
    `let` binding whose value is a `Surface` required exposing the `Surface` *type*
    from `Kit.Surface` (`import ... exposing (Surface)`), which I hadn't needed
    otherwise.

12. **`NoRedundantlyQualifiedType` immediately after.** Once I wrote
    `rowSurface : Surface.Surface`, a second rule demanded I simplify it to
    `Surface`. Two rules in sequence pushing opposite-feeling edits (annotate it /
    now don't qualify it) — minor, both auto-fixable, but a small back-and-forth.

## Notes

- No new elm-review suppressions were added; the run ends "I found no errors!"
  (the 54 remaining suppressed errors are the pre-existing repo baseline, untouched).
- `Native.div`/`Kit.*`/`Surface.*`/`Layout.*` all return
  `Element { html : Supported }`, and `Native.*` accept polymorphic-kind children,
  so mixing M3e components and layout wrappers as siblings unifies cleanly via the
  extensible-record phantom row. That part composed with zero friction.
