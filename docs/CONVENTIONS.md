# `M3e.*` component conventions

The rules every `M3e.*` component module follows. This doubles as the **porting
spec template**: an architect fills a spec per component (from the Material
content taxonomy), and the spec is implemented mechanically and gated by tests.
Canonical rationale: [ADR 0006](adr/0006-m3e-architecture.md).

## The shape (non-negotiable)

Every component is **view-style**:

```elm
view : { <required fields> } -> List (Option msg) -> Element { s | <tag> : Supported } msg
```

- **One concept.** No separate builder type, no `|> into` lift. `view` returns
  slot-ready content directly.
- **Required fields in the record.** A field is required iff the component is
  meaningless / inaccessible without it (see a11y below). Everything else is an
  option.
- **Options fold like Html attributes.** `type Option msg = …`; a private
  `apply : Option msg -> Config -> Config` folds them; `view` renders the folded
  config in one place (so order doesn't matter).
- **Result tag.** The return annotation pins the component's kind in the phantom
  row. Tag = the lowerCamel module name (`iconButton`, `chipSet`, `appBar`).

## Required vs optional

- **Required** (record field): the accessible name of a no-visible-text control
  (§a11y); the content a control is *about* (a text field's value model, a
  select's options); a mutually-exclusive choice (model it as a sum-typed
  required field, e.g. `action : Link String | Click msg`).
- **Optional** (folded `Option`): everything M3 marks optional — variants,
  sizes, icons, disabled, event handlers, density.

## Slots — accepted sets from the Material taxonomy

Derive each slot's accepted set from the m3e CEM + examples (the per-component
tables researched in `docs/research/`). Map to one of:

| Content kind (M3) | Slot type |
|---|---|
| single child of a fixed kind (`icon`) | `Element { s | <childTag> : Supported } msg` |
| homogeneous list (`chip-set → chip[]`) | `List (Element { s | <childTag> : Supported } msg)` |
| spec-heterogeneous region (app-bar `trailing`) | closed row listing each valid child kind **+ `element`** |
| arbitrary region (card body) | `List (Element any msg)` (free row) |

Rules:
- **Named slots inject `slot=`** (parent does `Node.withSlot "<name>"` over each
  child). Their accepted set includes **`element`**, never **`html`** — raw Html
  can't carry an injected slot, so it must be a compile error.
- **Default-slot regions inject nothing.** Their accepted set may include
  **`html`** (the raw escape).
- **Strict containers** (`chip-set`) list only their child kind — no escape.

## Accessibility by construction

- A control with **no visible-text fallback** (icon-only button, compact FAB,
  app-bar action buttons) takes its accessible `name : String` as a **required**
  field → emitted as `aria-label` (m3e aria-hides icon slots, so a slotted/
  `sr-only` child won't name it).
- A control with **visible text** uses that text as the name — no extra field.
- Relational wiring (label↔control `for`/`id`, `aria-labelledby`) is done by the
  parent via `Node.setAttribute` over the child IR (see `M3e.Field`).

## Styling (unchanged from ADR 0004)

No baked classes/tokens. Structural attributes from the spec are fine. Callers
add classes via a `class` option / the host attribute surface; the
`tailwind-m3e-web` bridge is the single styling source.

## Emitting the node

Hand-write `Node.element "<m3e-tag>" …` with explicit `Node.attribute` /
`Node.property` for relational + state attrs, and `Node.on` for events. (Using
`Cem.M3e.*` atoms under the hood awaits the codegen retarget — ADR 0006; until
then components are self-contained.)

- Use **`Node.property`** for web-component DOM properties (`open`, `selected`,
  `value`, `checked`) — these are what `Test.Html` can't see and the IR can.
- Use **`Node.attribute`** for relational/string attrs.

## The test every component ships

A unit test against the IR asserting, at minimum:

1. the element upgrades to the right tag,
2. its accessible name is present (required-name controls),
3. each value-bearing property/attribute the options set is visible in the IR,
4. (for parents) children carry their injected `slot=` / relational ids.

Plus, where a slot constrains kinds, a **negative compile check** (a fixture that
must *not* compile — a wrong child kind, or a raw `html` in a named slot).

## Per-component spec template

```
Module:        M3e.<Name>            (tag <m3e-...>)
Required:      { field : Type, ... } (incl a11y name if no visible text)
Options:       opt : Type            (one per optional setting)
Slots:         <slotName> : <accepted-set>  | region: free-row | container: child-only
A11y:          name required? relational wiring?
Properties:    <prop> via Node.property  (state the element reads as a DOM prop)
Events:        <event> -> msg
Escape:        html (region) | element (named slot) | none (strict)
Test:          tag, a11y name, <props>, slot injection; negative: <bad case>
```
