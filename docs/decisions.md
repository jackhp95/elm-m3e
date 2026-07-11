# Decisions

This is the living record of the durable design decisions behind elm-m3e —
the "why is it built this way?" answers that don't live comfortably in the code
or the reference docs. It is a companion to [`DESIGN.md`](DESIGN.md), which is
the theory of operation; this file is the reasoning trail. Each section states
one decision and the thinking that produced it, in prose. Where a decision was
recorded during development as a numbered ADR (the `docs/adr/` tree that has since
been folded into `DESIGN.md`), the number is noted in parentheses for anyone
digging through history. It is meant to be edited as the design keeps moving, not
frozen.

- [Generate the whole library, hand-write zero components](#generate-the-whole-library-hand-write-zero-components)
- [Emit an introspectable IR, not opaque `Html`](#emit-an-introspectable-ir-not-opaque-html)
- [The five-surface API — one IR, layers plus forms](#the-five-surface-api--one-ir-layers-plus-forms)
- [Composition over injection](#composition-over-injection)
- [Cardinality and required-presence are advisory, not typed](#cardinality-and-required-presence-are-advisory-not-typed)
- [Codegen-aware elm-review: generate facts, hand-write rules](#codegen-aware-elm-review-generate-facts-hand-write-rules)
- [The seam boundary — one loud, greppable crossing](#the-seam-boundary--one-loud-greppable-crossing)
- [The Kit is copy-paste userland, not published API](#the-kit-is-copy-paste-userland-not-published-api)
- [Regenerate in CI on a `@m3e/web` bump](#regenerate-in-ci-on-a-m3eweb-bump)
- [Unwrap the default slot; phantoms as guidance](#unwrap-the-default-slot-phantoms-as-guidance)
- [Builders are styling-free; expose host escapes](#builders-are-styling-free-expose-host-escapes)
- [The config is grown by evidence, permissive by default](#the-config-is-grown-by-evidence-permissive-by-default)

## Generate the whole library, hand-write zero components

Nothing in `src/M3e/` is hand-written per component. The hand-craft lives in the
`elm-cem` generator, in `config/slots.json`, and in the userland seam. An early
audit projected an irreducible ~13-module hand layer ("capture ceiling ≈ 80%"),
but re-examining the real `@m3e/web` source found **zero** runtime-imperative
component cases — every claimed-hand module turned out to be a pure IR-producing
function expressible as composition, and the two stragglers (Label, SplitButton)
dissolved once modeled as a governance seam and a typed-slot container
respectively (ADR 8, ADR 10). Making the whole surface generated is what lets a
`@m3e/web` upgrade regenerate the library instead of forcing a hand-merge, and it
keeps 122 components uniform rather than each accreting its own idioms.

## Emit an introspectable IR, not opaque `Html`

The pre-1.0 `Ui.*` layer wrapped web components as functions returning opaque
`Html msg`, and a whole-repo audit found that shape made the library's own thesis
— make impossible states impossible against the Material 3 spec, not against the
DOM — undeliverable (ADR 6). Opaque `Html` cannot be constrained (an icon slot
would accept anything) or composed (you cannot inject `slot=`/`for`/`id` into it),
and accessible names lived where `Test.Html` couldn't see them, so real bugs
shipped green through 252 unit tests. So a component now renders to a data
structure the library controls — the lazy IR `Element` — and the only eager point
is `toHtml` at the app root. That single decision is the root the rest of the
design hangs off: because the tree is still introspectable data right up to the
render exit, phantom types can guarantee a composition is valid before it collapses
to `Html`.

## The five-surface API — one IR, layers plus forms

There are five addressable API surfaces, and they split along **two orthogonal
axes** rather than one ladder (ADR 8 for the layers, ADR 13 for the forms). The
**layer axis** is a safety gradient over the same IR: `M3e.Raw.*` (partial
applications of `elm/html`, strings live here and nowhere else), `M3e.Html.*`
(phantom-typed attributes, eager component), and the top `M3e.*` (fully lazy IR,
typed slots) — deeper is rawer, less safe, more control. The **form axis** picks
how required and optional parts are passed on the top layer, and all three forms
return the identical `Element … msg` so they interchange freely: the standard
double-list form (`view [attrs] [content]`), the record form (`M3e.Record.*`,
which turns missing-required into a compile error), and the phantom-builder
pipeline (`M3e.Build.*`, which makes a duplicate-singular setter unwritable). Each
form converts exactly one advisory check into a compile-time one, so a team dials
in as much strictness as it wants without the library forcing the strictest shape
on everyone. All five surfaces exist on disk today (`Raw/`, `Html/`, the top
component modules, `Record/`, `Build/`).

## Composition over injection

The first config design absorbed "wrapper injects extra structure" cases (Slider
auto-adds a thumb, BottomSheet appends a close-trigger sentinel, SplitButton nests
a Button, form controls inject a native `<input>`) with a declarative
element-injection primitive. Reading the real `@m3e/web` source dissolved that
primitive: every case is already a *composition*, not an injection — the slider
renders consumer-supplied thumbs and derives `isRange` from how many you pass, the
bottom-sheet action is just a close-on-click member, the split button's leading is
just a Button in a slot. So the rule became: **always model added structure as
composition, never injection** (ADR 9). This is what made "hand = zero components"
reachable, and it means the code you write matches the DOM that appears — the
library is not silently manufacturing children behind your back.

## Cardinality and required-presence are advisory, not typed

Two slot properties could be encoded in the type system but at an ergonomic cost:
cardinality (some slots are singular, some accumulate) and required-presence (a
Button with no label is broken). A type-level guarantee is achievable — put
singular slots in a record, `Maybe` for optional-singular, required slots as plain
fields — but that taxes every component with a record and makes every
optional-singular slot a `Maybe` the caller must spell `Nothing` for (TreeItem
alone has four icon slots). Weighed against the project's values (uniformity over
per-component ergonomics, and "the code you write should match the code in the
browser"), the record tax was judged worse than the guarantee is worth, so these
two checks are handled by `elm-review` rules plus doc notes instead of type shape
(ADR 11). Kind and capability validity, by contrast, *are* always type-level and
never relaxed. Underpinning all of it is **IR faithfulness**: the generated IR
emits exactly what the caller composed — never adding, dropping, deduplicating, or
reordering. (This decision was later partly reconciled by the form axis above: the
record and build forms *do* lift required-presence and cardinality back into the
type system for teams that opt in.)

## Codegen-aware elm-review: generate facts, hand-write rules

The top layer is deliberately loose — the barrel exposes one component-agnostic
`variant` that accepts every component's tokens, general slot setters, and the
advisory-only checks above — so the finer facts (is this enum value valid for
*this* component, is a required slot present, is a general slot better written as
its specific name) are intentionally not in the types; they are elm-review's job
(ADR 12). Those checks need facts only the manifest and config know, and an
autonomous migrator needs machine-actionable guidance rather than prose. So the
generator emits a plain-Elm **facts** table (component → valid enums, required
slots, multi slots, shorthand↔specific names, the per-surface function map) and a
small set of hand-written, configurable, unit-tested generic rules consume it.
Universal invariants (the `toHtml` gate, the seam gate, no raw attribute on a
component slot) are hand-written and parameterized; component-specific checks are
one generic rule each, driven by the facts. The rules live in the sibling
`elm-review-cem` package, which keeps them reusable across any CEM-generated
library, not just this one.

## The seam boundary — one loud, greppable crossing

Userland always needs things the generator never will — an i18n text component, a
custom link, a layout wrapper — and they need the *same* phantom typing the
generated code enjoys. The decision is that there is exactly **one** place where
raw `Html` crosses into the typed IR, and it is loud and auditable (ADR 14). The
opaque `Element` type and every phantom-asserting op (`fromNode`, `fromHtml`,
`recast`, the seam stampers) live only in `*.Internal` modules; the public
`M3e.Element` re-exposes just the safe subset, so a userland `import M3e.Element`
literally has no `fromNode` in scope and cannot mint an `Element` from raw HTML.
That is a structural fence — Elm's own module exposure, not a lint rule. On top of
it, semantic seams are config-declared and generator-typed but userland-filled
(`text`/`link`/`label` are holes a team fills, not values the library defines),
and `NoSeamOutsideAllowedModules` keeps every crossing inside a few blessed adapter
modules. The escape (`Seam.recast`) is deliberately kept as a greppable feedback
signal so the design-system owner can audit each use and fix either the app or the
config, rather than a silent hole.

## The Kit is copy-paste userland, not published API

The producers that complete the composition surface — `Kit` (`text`/`link`),
`Native` (native-HTML IR: `div`/`span`/`a`/…), and the app's `Seam` adapter — live
in `docs/kit/` and are explicitly **copyable, not part of the published package**.
Fork consumers copy them into their own app and adapt them. The reasoning: these
are exactly the pieces the library intentionally does not opinionate. A team whose
"text" is an i18n key resolving to the user's language should fill that typed hole
themselves, not inherit ours; navigation is a plain `<a>` whose routing is the
app's business. Publishing them would freeze one team's opinion into everyone's
dependency graph, so instead they ship as a small, honest starting point you own
after you copy it. `elm.json` `source-directories` points at `src` + `docs/kit` so
the reference site dogfoods exactly what a consumer would copy.

## Regenerate in CI on a `@m3e/web` bump

Because the library is fully generated, an upstream `@m3e/web` version bump must
regenerate `src/` or the binding drifts from the web components it wraps. A
`regen-on-bump.yml` workflow wires this: when a PR changes `@m3e/web`, CI installs
the manifest, fetches the (now public) `elm-cem` generator, runs the deterministic
regen command, `elm-format`s the output, and commits the diff back onto the PR so
the existing CI then re-validates that the regenerated code still compiles (ADR 8
covers the generator side; the planning notes referred to this regen-in-CI workflow
as "ADR-8"). Two details are load-bearing and both are the result of a real bug:
the regen is **deterministic** (a no-op bump produces no commit), and the output is
`elm-format`ed before commit, because committing the generator's raw output
introduced large spurious formatting churn that swamped the real API diff on every
bump. The generator being public means the clone needs no token; a PAT
(`ELM_CEM_TOKEN`) is optional and only needed to make the bot's regen commit
re-trigger CI automatically.

## Unwrap the default slot; phantoms as guidance

An earlier model wrapped the top layer's default-slot children in a `Content`
newtype so the slot name could be stamped. That was reversed: on the `M3e` top
layer the default slot now takes raw `Element` children directly, and the `Content`
module was retired (ADR 15). The rationale was that the wrapper was ceremony for
the common case — most default slots impose no restriction, so the wrapping bought
little and cost every call site a layer of indirection. Alongside this, the posture
on the standard form's phantom rows was settled as **guidance, not an absolute
boundary**: the shipped `Cem.Lenient` lint posture flags a slot child only when its
kind resolves statically and stays quiet otherwise, which is the accepted trade for
the ergonomic standard form. A team that wants the linter to hold the full slot-kind
guarantee can switch to `Cem.Strict`; the record and build forms hold it in the
type system regardless.

## Builders are styling-free; expose host escapes

A component builder never bakes in styling — no hardcoded `class "text-title-medium"`
on a card headline (ADR 4). Building the docs site against the old `Ui.Card` showed
that hardcoded styling defeats the Tailwind bridge, drifts from the M3 tokens the
elements already emit themselves, and blocks callers from composing their own
layout. The flip side of that rule is that callers need a way to attach a
`class`/`data-*`/`aria-*`/handler to the underlying host element, because the audit
found 50 of 52 old builders had no such affordance and the only workarounds (fork
the module, or wrap in a `<div>` that breaks the typed-slot contract) were both bad.
So host-box components expose an escape that appends raw attributes to the host
element (ADR 7), applied where a component's host needs caller-driven sizing or
styling (Shape, ScrollContainer, Skeleton, Progress, and any other whose host needs
it).

## The config is grown by evidence, permissive by default

A component absent from `config/slots.json` gets safe, maximally permissive
defaults: a free child row, no required fields, its default slot degrading to a
loose `"arbitrary"` slot where everything still composes. The looseness is
*visible* in the generated signature (an open row rather than a closed kind set),
not silently wrong. The posture is deliberately **permissive-default-you-trim**: a
freshly generated CEM composes everything, and teams *subtract* invalid
compositions in config rather than opt into valid ones. Because being wrong in
config is cheap — fix the entry and regenerate — the config is grown by evidence:
only a minority of entries are evidence-based today, and the rest ride the
permissive defaults until a real composition proves a tighter fact is warranted.
This keeps the library shippable from day one on a new `@m3e/web` release instead
of blocking on hand-authoring every slot.
