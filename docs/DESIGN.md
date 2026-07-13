# The design of elm-m3e

How the library is built and why. elm-m3e is a **generated** Elm binding over
matraic's `@m3e/web` Material 3 web components: the [`elm-cem`](https://github.com/jackhp95/elm-cem)
generator reads each component's custom-elements manifest (CEM) plus a small
hand-authored `config/slots.json`, and emits the layers described here. Nothing
in `src/M3e/` is hand-written per component; the hand-craft lives in the
generator, the config, and the userland seam.

The schema for the config is [`CONFIG_SCHEMA.md`](CONFIG_SCHEMA.md). This document
is the theory of operation.

Every Elm sample below is copied from, or type-checked against, the current
`src/`. Where a signature is abbreviated its shape is preserved.

## 1. The three layers

The one idea: **everything is a partially-applied function stored un-applied in an
IR, and the only eager point is `toHtml` at the app root.** The element tag is a
partially-applied `Html.node`; an attribute is a partially-applied
`Html.Attributes.attribute`; the IR holds those partial applications (plus child
IR) and runs them only when the tree is converted to opaque `Html`.

Two consequences fall out:

- **Each string exists exactly once.** No layer re-types `"m3e-button"` or
  `"variant"`; they are baked into the bottom layer's partial applications and
  passed *as functions* upward. Rule of thumb: if the same string does the same
  job on two layers, something is wrong.
- **The IR exists for composition, not introspection.** Its reason to exist is
  that you can still add a `slot=` to an element to associate it with a parent
  *before* it collapses to opaque `Html`. Opaque `Html` cannot be composed; the IR
  plus phantom types can, and they guarantee the composition is valid.

Each layer reuses the one below it — it passes the lower layer's functions, never
re-deriving them. Going deeper means less safety and less convenience but more
control. This is the same escapable-but-convenient gradient the whole library is
built on, mirrored in the html → element → child shape:

```
M3e.*            top     — lazy IR for components AND attrs; phantom kind rows; only toHtml is eager
  └ M3e.Html.*    middle  — lazy IR attributes; eager component (→ Html); phantom Value + capability rows
      └ M3e.Raw.*  bottom — partial applications of elm/html; no phantom types; fully applied → Html
          └ raw elm/html — the floor; opaque
```

### The layers in full, on `<m3e-button>`

**Bottom — `M3e.Raw.Button`** — partial applications, no phantom types. Every
function, fully applied, returns `Html` / `Html.Attribute`. The strings live here
and nowhere else:

```elm
button : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
button =
    Html.node "m3e-button"

variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"
```

**Middle — `M3e.Html.Button`** — captures attribute application as IR; phantom types
start here. A setter does not evaluate when written — `variant Value.filled` just
collects the bottom function and its value into an `Attr`. The held attrs are
evaluated to opaque `Html.Attribute` only when the **component** is applied:

```elm
variant :
    M3e.Token.Value { elevated : M3e.Token.Supported, filled : M3e.Token.Supported
    , outlined : M3e.Token.Supported, text : M3e.Token.Supported, tonal : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg

button : List (M3e.Html.Attr.Attr { … } msg) -> List (Html.Html msg) -> Html.Html msg
button attributes children =
    M3e.Raw.Button.button
        (List.map M3e.Html.Attr.toAttribute attributes)
        children
```

**Top — `M3e.Button`** — defers component composition too; returns lazy IR
(`M3e.Element.Element`). The constructor is `view`; setters like `variant` are
reused verbatim from the middle; slot placers stamp `slot=`:

```elm
view :
    List (M3e.Html.Attr.Attr { … } msg)                      -- row 2: attr capabilities (closed)
    -> List (M3e.Element.Element { text : Supported, icon : Supported, … } msg)  -- row 3: accepted kinds (closed)
    -> M3e.Element.Element { s | button : M3e.Token.Supported } msg              -- row 3: "I AM a button"

variant =
    M3e.Html.Button.variant

icon : M3e.Element.Element { icon : Supported, loadingIndicator : Supported } msg -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.withSlot "icon" el
```

A real call, from `src/M3e/Button.elm`'s own examples:

```elm
M3e.Button.view [ M3e.Button.variant M3e.Token.filled ] [ Kit.text "Filled" ]
```

is still 100% IR. Only the render exit at the app root — `M3e.Element.toNode >>
M3e.Node.toHtml` — builds opaque `Html`.
`M3e.Button.variant M3e.Token.square` is a compile error (`square` is not in the
variant `Value` row); a `M3e.Card.view …` in the content list is a compile error
(`card` is not among Button's accepted kinds).

### The three phantom rows

All three are extensible records, all appear on public return types. The IR erases
them to uniform thunks internally so the node list stays homogeneous — but the
erasure happens *behind* the public signatures, so every composition a consumer
writes is fully type-checked.

| # | Row | Guards | Producer / consumer | Introduced |
|---|-----|--------|---------------------|------------|
| 1 | `Value { v \| … }` | which **values** an enum attr accepts | token open / setter input | middle |
| 2 | `Attr { c \| capability }` | which **attrs** a component admits | setter open / component closed | middle |
| 3 | `Element { s \| kind }` | which **kind** an element *is* (for slotting) | child open / slot closed | top |

Composition is **add-only**: it only adds attributes (as `icon` above adds a
`slot=`); it never changes or removes them, so the types never need to. If an
attribute is set twice, `elm/html`'s natural last-wins gives a predictable result
— no dedup machinery. Common valid compositions ship as helpers (`M3e.Button.icon`)
that return the right kind so they fit the right slots.

## 2. The slot model

`elm/html`'s last-wins resolves duplicate **attributes** (set `disabled` twice, the
last wins). It does **not** apply to **slotted children**: every element carrying
`slot="trailing"` renders, in order. That is exactly the AppBar-trailing case —
several trailing actions, all shown.

- **Slotted children accumulate; they do not collapse.** Multi-element named slots
  are a real, desired pattern.
- A genuinely singular slot (one icon) is **not** enforced by HTML — put two and
  both render (broken). So cardinality must be stated **explicitly**, never
  inferred from HTML semantics.

Each slot therefore carries four explicit axes in `config/slots.json` (keyed by the
slot's manifest name; the unnamed slot is keyed **`"unnamed"`**):

1. **name** — `"unnamed"` for the default slot; the manifest name otherwise.
2. **cardinality** — `multi: true` accumulates; `false` (default) is singular.
3. **optionality** — `required: true` (routed to the required record) vs optional.
4. **kinds** — the accepted-kind union.

The `kinds` taxonomy has four distinct cases, and conflating them was a real bug
(≈31 open slots once wrongly authored as closed):

- **specific kinds** — `["icon", "text"]`: the slot's phantom row is closed to those
  component kinds.
- **`"arbitrary"`** — the bare string: the slot accepts *any* kind by design (a Card
  body, a Dialog body, a panel region). Its phantom row is an open row. Set this
  when the element imposes no restriction — no `::slotted` selector, no tag query,
  no `instanceof` filter.
- **element escape** (implicit, never listed) — the raw element/native-HTML escape
  hatch is available on *every* slot regardless of `kinds`; it is the type-escape,
  not the slot's intent.
- **`[]` empty** (rare) — genuinely no typed children, only when the element rejects
  element children. An unrestricted slot is `"arbitrary"`, never `[]`.

(Older design notes used `"any"`/`"default"` for the last-two vocabulary; the
config token is `"arbitrary"`/`"unnamed"` — see the vocabulary note in
[`CONFIG_SCHEMA.md`](CONFIG_SCHEMA.md).)

## 3. Forms at the top

There are **two orthogonal axes**, and depth on one is not depth on the other.

- **The layer axis** (`M3e` → `M3e.Html` → `M3e.Raw`) is the safety gradient of
  §1: deeper is rawer and less safe.
- **The form axis** picks *how required and optional parts are passed* on the top
  layer. All three forms return the identical `M3e.Element.Element … msg`, so they
  nest and interchange freely; a form's guarantees live entirely on its **input**
  side. Namespace depth here names a form variant, not less safety —
  `M3e.Record`/`M3e.Build` are deeper yet *safer*.

| Form | Namespace | Call form | Extra guarantee over standard |
|------|-----------|-----------|-------------------------------|
| **standard** double-list | `M3e.*` | `view [ attrs ] [ content ]` | — (the baseline) |
| **Record** (required record + lists) | `M3e.Record.*` | `view { required } [ attrs ] [ content ]` | missing-required is a compile error |
| **Build** (availability-phantom pipeline) | `M3e.Build.*` | `seed { required } \|> setter \|> … \|> build` | duplicate-singular is unwritable |

Each step converts exactly one advisory check into a compile-time one:

| Mistake | standard | Record | Build |
|---------|----------|--------|-------|
| Invalid enum token | compiler | compiler | compiler |
| Wrong slot-kind child | compiler | compiler | compiler |
| Missing **required** (label/action) | linter | **compiler** | **compiler** |
| **Duplicate singular** (`icon` twice) | linter | linter | **impossible** |

The standard form carries required content as ordinary children and leans on the linter for
missing-required. The Record form hoists required parts into a record field — present exactly
once by construction:

```elm
M3e.Record.Button.view
    { content = Kit.text "Save", action = M3e.Action.onClick SaveClicked }
    [ M3e.Button.variant M3e.Token.filled ]
    []
```

The Build form threads every optional through a consuming-row `Builder` (`{ c | field :
Available }` on a setter's input, `{ c | field : Used }` on its output), so applying
a singular setter twice fails to type-check. Import it qualified:

```elm
import M3e.Build.Button as Button

Button.button { content = Kit.text "Save", action = M3e.Action.onClick SaveClicked }
    |> Button.variant M3e.Token.filled
    |> Button.build
```

**The matrix is sparse.** The top barrel `M3e` (`import M3e exposing (..)`) offers
only the standard form — its constructors plus the generalized setters
(`variant`, `slotIcon`, …). The Record form has its own barrel, `M3e.Record`, but only for
the components that actually have required content. The Build form has **no** barrel: you
import the per-component `M3e.Build.*` module qualified. So "one import for
everything" is a standard-form affordance; the Record and Build forms are opt-in and, for the Build form, per-component.

### Barrel setter naming: `attr`-prefixed, one alias per function

Shared scalar attribute setters are re-exposed on the barrel under a single,
self-categorizing `attr`-prefixed name (`attrDisabled`, `attrValue`, `attrName`);
the underlying `M3e.Html.Shared.*` function keeps its plain name. The generator
emits **one** barrel alias per setter — earlier output duplicated some as both a
bare (`name`, `value`) and an `attr`-prefixed (`attrName`, `attrValue`) constant
for the *identical* function, and those bare duplicates are gone. Where two
setters genuinely differ they are both kept: an attribute whose type conflicts
across components (issue #23) is shared as the dominant-typed `attrValue : String
-> …` **plus** a type-suffixed `attrValueFloat : Float -> …`, each carrying a
distinct phantom capability (`value` vs `valueFloat`) so the wrong-typed setter
can never unify against a component. ARIA setters keep their natural `aria*` names.

## 4. The seam boundary

Userland needs to build things the generator never will — an i18n text component, a
custom link, a layout wrapper — and give them the *same* phantom typing the
generated code enjoys. Two mechanisms make that safe.

**Semantic seams are config-declared, generator-typed, userland-filled.** The
`_seams` block in `config/slots.json` names each seam and the kind it produces; the
generator emits a contract type and a stamper in `M3e.Seam`, and the team writes the
body. `text`/`link`/`label` are seams, not library-defined values — a team whose
"text" is an i18n key resolving to the user's language fills the same typed hole:

```elm
-- docs/kit/Seam.elm (the app's designated seam module)
text : String -> M3e.Element.Element { s | text : M3e.Token.Supported } msg
```

**The raw↔phantom crossing lives only in `*.Internal` modules.** The opaque
`Element` type and every phantom-asserting op (`fromNode`, `fromHtml`,
`recast`, the seam stampers) live in `M3e.Element.Internal`; the public
`M3e.Element` re-exposes only the safe subset (`map`, `toNode`, `withSlot`,
`withAttr`, and the opaque type without `(..)`). A userland `import M3e.Element`
has no `fromNode` in scope and so
**cannot** mint an `Element` from raw HTML. This is a structural fence — Elm's own
module exposure, not a lint rule. `*.Internal` is imported only by generated `M3e.*`
code and the one designated userland `Seam` module.

**Typed native HTML** rounds it out. Config `_native` lists the raw tags emitted as
first-class IR `Element`s (`div`, `span`, `p`, `a`, `img`, `ul`, `li`, …). They are a
public typed facade that *cannot* lie — the kind follows the tag, attributes follow
HTML's own typing (`href` on anchors, `for` on labels), so `M3e.Native.div [ href …]`
is a compile error. Semantic native tags stamp a specific kind (`a → link`); the
rest carry the open `html` kind and so fit any `"arbitrary"` slot.

The posture is **permissive-default-you-trim**: a freshly generated CEM defaults
maximally permissive (top ≈ middle, everything composes) so teams *subtract*
invalid compositions in config rather than opt into valid ones. When a team believes
the design system is genuinely wrong, `Seam.recast` coerces the kind row — but
it is loud and greppable, and `NoSeamOutsideAllowedModules` keeps every crossing
inside a few blessed adapter modules, so the design-system owner can audit each use
and either fix the app or fix the config. The escape is a feedback signal, not a
silent hole.

## 5. Advisory vs compile-time

Enforcement splits by what each invariant is worth at the type level:

- **Type level, never relaxed:** *kind* and *capability* validity, via the phantom
  rows of §1. A wrong attribute or a wrong-kind slot child is a compile error on
  every form.
- **Linter, project-wide:** *cardinality* and *required-presence*. A record tax on
  every component was judged worse than the guarantee is worth (TreeItem alone has
  four icon slots — every optional would become a `Maybe` the caller spells
  `Nothing`), so these are codegen-aware `elm-review` rules plus doc notes, not type
  shape. They catch the mistake and — faithfully — the IR still renders exactly what
  was composed.

The always-on rule set (`review/src/ReviewConfig.elm`, from the sibling
[`elm-review-cem`](https://github.com/jackhp95/elm-review-cem) package) is:
`validEnumValue`, `requireSlot`, `singularSlot`, `singularAttribute`,
`missingRequiredAttribute`, `missingRequiredSingularSlot`, and
`validSlotKindWith Cem.Lenient`. Two auto-fix rules — `preferBarrel` and
`preferSpecificBarrelSlot` — upgrade loose generalized code to the component-precise
form.

`Cem.ValidSlotKind` has two postures. `Lenient` (the shipped default) flags a
slot child only when the child's kind resolves statically, and stays quiet where it
cannot — the accepted trade for the ergonomic standard form, whose phantom rows are
guidance rather than an absolute boundary. `Strict` flags the unresolved cases too,
for a project that wants the linter to hold the full slot-kind guarantee that forms
4 and 5 hold in the type system.

**IR faithfulness underpins all of this:** the generated IR emits exactly what the
caller composed — never silently adding, dropping, deduplicating, or reordering. A
compile error from the phantom rows is not a faithfulness violation; it rejects
invalid input before anything is built, and never rewrites valid input.

## 6. Regeneration

The pipeline is: **CEM + `config/slots.json` in, the layers of §1–§3 out.** The
generator reads each component's manifest for its tag, attributes, events, and
slots, applies the config's per-component facts (slot kinds, required fields,
static attrs, id-wiring, variant-split groups), and emits the bottom/middle/top
modules, the `M3e.Record`/`M3e.Build` forms, the `M3e` and `M3e.Record` barrels,
the `M3e.Seam`/`M3e.Native` contracts, and the `Facts` the elm-review rules and the
facet translator read.

A component **absent from the config gets safe defaults**: a free child row, no
required fields, no groups. Its default slot degrades to a loose `"arbitrary"` slot
— everything still composes, and the looseness is *visible* in the generated
signature (an open row rather than a closed kind set), not silently wrong. Because
being wrong in config is cheap — fix the entry and regenerate — the config is grown
by evidence: ≈28 of ≈100 entries are evidence-based today, the rest ride the
permissive defaults until a real composition proves a tighter fact.

## 7. The facet layer stack and the atom foundation

The cross-CEM initiative (2026-07-12) added two concepts that underlie the
package split and the shared-atom vocabulary. They are described in full in the
guides ([`TheLayers`](guides/TheLayers.md), [`Seams`](guides/Seams.md),
[`Glossary`](guides/Glossary.md)); this section gives the one-paragraph versions.

**The facet stack.** The layer axis (§1) and the form axis (§3) produce five
addressable packages when split for publishing. Going from narrowest to broadest
import surface: `elm-m3e-core` (phantom-row runtime types: Kind, Token,
Element, Node, Html.Attr), `elm-m3e-raw` (partial HTML applications),
`elm-m3e-html` (middle-facet attribute setters), `elm-m3e` (standard form: full
components + barrel + Action + Seam + Coerce), then `elm-m3e-record` and
`elm-m3e-build` (stricter forms, both depending on standard). A seventh package,
`elm-m3e-review-facts`, carries only `M3e.Review.Facts` and is installed in
`review/` apps only — its dep on `elm-review-cem` must not enter app trees.
The package boundaries are mechanically derived from bucket rules + import-DAG
checks, not hand-listed.

**The atom foundation.** Below the generated m3e surface sits `markup-core`
(from `jackhp95/markup-core`, produced by the elm-cem repo). It owns the shared
runtime types (`Markup.Element`, `Markup.Node`, `Markup.Kind`) and the
accessible-by-construction atom constructors (`Markup.Atoms`: text, link, label,
icon). Atoms carry `Markup.Kind.Shared` in their kind row. An m3e slot that opts
in with `shared:text` in its config accepts any `Markup.Kind.Shared`-typed
element regardless of which library produced it. Private-tier components carry
`M3e.Kind.Brand`, which only unifies with other M3e-kind rows — foreign elements
are rejected at compile time.

**Seam as system crossing.** A seam is any crossing point where a raw or
foreign value enters the typed IR. Two sanctioned mechanisms exist:

- `Seam.recast` — the general loud crossing. It coerces any `Element` to any
  other kind, with no semantic claim. Always greppable; always review-enforced.
  Use when the crossing has no stable semantic identity.
- `M3e.Coerce.*` (config `_coerce` block) — named, typed, config-blessed
  crossings. Each function makes a semantic claim (a Chip acting as a button) and
  is declared in config, so the tool can reason about it. Use for crossings that
  recur with the same intent.

The two are related but not interchangeable. `recast` is the general escape valve;
named coercions are sugar for the recurring well-reasoned cases. Neither is silent:
both produce greppable function calls, and `NoSeamOutsideAllowedModules` restricts
all seam use to declared modules.

## Performance

**The API/phantom-type design is not the compile bottleneck; the elm-pages docs
build dominates.** A recurring worry is that the generated top layer — the
phantom-typed IR, the extensible capability rows, and the barrel that re-exports
every component — might be expensive for the Elm compiler. A benchmark run
(2026-07) established it is not.

Method: the *same* corpus of 331 examples was authored on all six call-site variants
(raw bottom vs. `M3e.Html`/`M3e`/barrel/Record/Build, drawn from the
`config/examples.*.json` corpora) and each variant was compiled with cache and
thermal discipline — separating cold builds (`elm-stuff` deleted) from warm
incremental builds, since the earlier variance seen was hot *cache*, not CPU.
All six variants compiled identically within noise (warm medians 0.15–0.20 s,
cold 0.5–0.7 s): no phantom-type or barrel penalty. A whole-app measurement
told the same story — `elm make` of all 34 docs route modules cold is ~1.0 s
(library-only cold ~0.6 s, no-op floor ~0.17 s), ~0.02 s incremental per page,
with no kitchen-sink page. The reported "slow docs compile" is the **elm-pages
toolchain** — the prerender/vite pipeline and the elm-review pass it shells out
to (which re-parses everything and runs the full codegen-aware rule set) —
not `elm make` and not this library's type-level design.

The one-off benchmark harness (`scratchpad/compile-bench/`) is a gitignored
session artifact and is not retained in the repo; this paragraph is its durable
conclusion.
