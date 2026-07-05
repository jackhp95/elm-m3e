# Codegen-aware translator — design (epic #138, third ship — issue #145)

Date: 2026-07-05
Status: Proposed — user review pending before implementation.
Ship: third — the D6 translator. Depends on the first ship's Facts fields being
populated and the second ship's ⑤ Build emitter (both landed on `main`).
Governing ADRs: [0012](../../adr/0012-codegen-aware-elm-review.md) (codegen-aware
review), [0013 (amended)](../../adr/0013-top-shape-matrix-and-translation.md)
(top-shape matrix and the translation lattice).
Coordinated by: [epic #138 shipping coordination](2026-07-03-epic-138-shipping-coordination.md).

## 1. Purpose

Deliver **D6** from epic #138: elm-review rules that auto-fix a call site from
any one of the five addressable API surfaces to any chosen target. The lattice
is 5 × 5 = 25 total, minus 5 identities = 20 non-trivial directions. All 20
ship in one pass because the algorithm is a single normalize-and-re-emit —
5 parsers × 5 emitters. Every direction is total: any parse failure or
un-fabricateable required is discharged through a Seam escape hatch, which the
existing `NoSeamOutsideAllowedModules` rule (or the developer's eye) then
flags for hand-fix.

## 2. Terminology and rename — `Shape` → `Surface`

ADR 0013 uses **layer** for the escape gradient (①/②/③ — the raw→typed→composable
axis) and **shape** for the three top variants (③/④/⑤). D6 has to treat all
five as one 5-way choice, so this spec uses a single unified word: **Surface**.
The specs and CONTEXT.md already say "five addressable API surfaces" throughout;
`Surface` matches that language exactly.

**Naming:**

| # | Namespace | Surface name |
| --- | --- | --- |
| ① | `M3e.Cem.Html.*` | `Html` |
| ② | `M3e.Cem.*` | `Cem` |
| ③ | `M3e.*` | `Standard` |
| ④ | `M3e.Record.*` | `Record` |
| ⑤ | `M3e.Build.*` | `Build` |

`Standard` for ③ (rather than `Plain`, `Top`, `Slots`, `View`, or the ordinal
`Shape3`) because ③ is the default, no-adornments top-layer shape a reader
lands on when they import `M3e.<Comp>`. `Standard` reads as "the ordinary
top-layer API" without falsely implying the others aren't top-layer.

**Breaking change:** the generator's `Shape = Shape3 | Shape4 | Shape5` becomes
`Surface = Html | Cem | Standard | Record | Build`. `Html` and `Cem` are new
constructors; `Shape3`/`Shape4`/`Shape5` become `Standard`/`Record`/`Build`.
The emitted `M3e.Review.Facts.Shape(..)` and `Fact.shapes` become `Surface(..)`
and `Fact.surfaces`. Consumer breakage is confined to `review/src/` — the rules
that import `Shape(..)` (three today: `MissingRequiredAttribute`,
`MissingRequiredSingularSlot`, `Facts` helper). All are updated in the same
regen commit.

## 3. The five rules

One elm-review rule per target surface, thin wrappers over a shared library
described in §4:

- `TranslateToHtml`   — target ① `M3e.Cem.Html.*`
- `TranslateToCem`    — target ② `M3e.Cem.*`
- `TranslateToStandard` — target ③ `M3e.*`
- `TranslateToRecord` — target ④ `M3e.Record.*`
- `TranslateToBuild`  — target ⑤ `M3e.Build.*`

**Public API (each rule):**

```elm
-- review/src/TranslateToBuild.elm
module TranslateToBuild exposing (rule)

import M3e.Review.Facts exposing (Fact)
import Review.Rule exposing (Rule)
import Translate.Rule

rule : List Fact -> Rule
rule facts =
    Translate.Rule.rule
        { facts = facts
        , target = Translate.Rule.Build
        }
```

No mode, no `sources` config, no annotation gating. The rule fires on every
call site *not* at its target surface and produces an auto-fix. File and
directory scoping goes through elm-review's native `Rule.ignoreErrorsForFiles`
/ `Rule.ignoreErrorsForDirectories`. If a project doesn't want a canonical
surface, it doesn't enable the rule.

**Sample `ReviewConfig.elm` entry (in-project use):**

```elm
import TranslateToBuild

config : List Rule
config =
    [ ...
    , TranslateToBuild.rule M3e.Review.Facts.facts
        |> Rule.ignoreErrorsForDirectories [ "src/legacy" ]
    ]
```

## 4. Architecture — the shared library

```
review/src/
  Translate/
    Canonical.elm       -- the canonical intermediate type + smart ctors
    Parse.elm           -- 5 parsers, one per Surface; produces Canonical from Node Expression
    Emit.elm            -- 5 emitters, one per Surface; produces String from Canonical
    Residue.elm         -- helpers that emit Seam.* wrappings
    Rule.elm            -- shared rule scaffold (imports, Fact indexing, error reporting)
  TranslateToHtml.elm
  TranslateToCem.elm
  TranslateToStandard.elm
  TranslateToRecord.elm
  TranslateToBuild.elm
```

**Data flow (one call site):**

1. Expression visitor lands on `Application` node.
2. Resolve module of the function head via `Review.ModuleNameLookupTable` — is it
   one of the 5 surfaces? If not, skip.
3. Identify the component via Facts (`module_` matches).
4. If the recognised surface equals the target surface, skip (identity — no fix).
5. `Translate.Parse.<surface>` → `Canonical`. Parsing is total: any
   un-classifiable sub-expression (e.g. a `view` variable passed as `attrs`)
   becomes `EscapedAttr` / `EscapedContent` / `DynamicAttrTail` / whole-node
   Seam residue (§9), so the parser never fails — the residue paths handle
   every irregularity.
6. `Translate.Emit.<target>` → `String`. Emitter calls into `Translate.Residue`
   for pieces that can't be represented cleanly at the target.
7. `Rule.errorWithFix` — full-call `Fix.replaceRangeBy` on the outer
   `Application` node's range with the emitted string; plus any import fixes
   for target-side modules.

**Import management.** The rule adds imports of target-side modules
(`import M3e.Build.Button as Button` when translating a Button call to ⑤; or
`import M3e.Cem.Attr` when Seam-wrapping into an Attr list) and removes imports
that become unused. Import fixes are separate `Fix.insertAt`/`Fix.removeRange`
operations layered onto the same `errorWithFix`. Existing rule
`PreferSpecificSlot` already does this — same pattern reused.

## 5. Canonical intermediate

Kept flat and expression-opaque: values travel as elm-syntax `Node Expression`
unmodified whenever possible; only the *role* of each is classified.

```elm
module Translate.Canonical exposing
    ( Canonical, AttrItem(..), SlotItem(..), ActionExpr(..)
    )

import Dict exposing (Dict)
import Elm.Syntax.Expression exposing (Expression)
import Elm.Syntax.Node exposing (Node)
import Elm.Syntax.Range exposing (Range)
import M3e.Review.Facts exposing (Surface)


-- Surface is imported from Facts (re-exported from the generator's output).
-- Recap of the constructors: `Html | Cem | Standard | Record | Build`.


type alias Canonical =
    { component : String              -- Facts key, e.g. "button"
    , sourceSurface : Surface         -- for diagnostics
    , sourceRange : Range             -- full-call range for Fix.replaceRangeBy
    , attrs : List AttrItem           -- attr-style pieces (action-attrs lifted out)
    , content : List SlotItem         -- content-style pieces (required-content lifted out)
    , requiredContent : Maybe (Node Expression)   -- ④/⑤ content field, or nothing
    , requiredAction : Maybe ActionExpr           -- unified action representation
    , otherRequired : Dict String (Node Expression)  -- component-specific required fields
    }


type AttrItem
    = KnownAttr { name : String, value : Node Expression }
        -- setter name normalized (e.g. "variant"); value is the raw arg expr
    | EnumTokenLossy { name : String, tokenText : String, range : Range }
        -- ① `variant "purple"` where "purple" isn't in Facts enums → uphill residue
    | EscapedAttr { raw : Node Expression }
        -- wraps at target via Seam.asAttribute; carries the unmodified expression
    | DynamicAttrTail { raw : Node Expression }
        -- e.g. `myAttrs` at end of an attr list; splices via List.append at target


type SlotItem
    = KnownSlot { name : String, body : Node Expression }
    | UnknownSlotName { name : String, body : Node Expression, range : Range }
    | EscapedContent { raw : Node Expression }
    | DynamicContentTail { raw : Node Expression }


type ActionExpr
    = AttrStyle { name : String, value : Node Expression }
        -- from ①/②/③: `onClick DoThing` / `href "..."` / `toggle True`
    | RecordStyle { raw : Node Expression }
        -- from ④/⑤: `M3e.Action.onClick DoThing` — passed through unmodified
```

**Key normalization decisions:**

1. **Action is unified.** ①/②/③ store `AttrStyle {name, value}`; ④/⑤ store
   `RecordStyle {raw}`. When source and target agree on style, pass-through.
   When they disagree, convert via the Facts action-map (§10) — falling back
   to whole-node Seam escape (§9) if the map has no entry.

2. **Required-content is lifted.** For ①/②/③, the parser scans the child list
   for the "required content" position — driven by Facts (a `requiredSlots`
   entry containing `"unnamed"` names it as required, and the child at the
   default-slot position is lifted). If not found, `requiredContent = Nothing`
   and uphill-to-④/⑤ triggers whole-node Seam escape (§9).

3. **Setter-name normalization.** ①/② use kebab-case slot names via
   `Html.Attributes.attribute "slot" "icon"`; ③/④/⑤ use camelCase setter names.
   Facts' `slotRewrites`/`attrRewrites` are the bridge; the parser normalizes
   into the camelCase setter name, and the emitter maps back to kebab-case
   when targeting ①/②.

4. **Expressions are opaque.** The parser doesn't rewrite sub-expressions —
   it just classifies. `M3e.Value.filled` stays as-is when copied between
   surfaces that both use tokens; converted to `"filled"` string literal only
   when target is Html (via Facts' `enums` lookup, reverse direction).

## 6. Parsers (worked examples per surface, `<m3e-button>`)

Running example: a `filled` button, label "New", leading `add` icon, `onClick DoThing`.

### 6.1 Parse.html — from `M3e.Cem.Html.*`

**Input:**
```elm
M3e.Cem.Html.Button.button
    [ M3e.Cem.Html.Button.variant "filled"
    , M3e.Cem.Html.Button.onClick DoThing
    ]
    [ Html.text "New"
    , M3e.Cem.Html.Icon.icon
        [ M3e.Cem.Html.Icon.name "add"
        , Html.Attributes.attribute "slot" "icon"
        ]
        []
    ]
```

**Canonical produced:**
```
component = "button"
sourceSurface = Html
attrs = [ KnownAttr { name = "variant", value = <String "filled"> } ]
requiredAction = Just (AttrStyle { name = "onClick", value = <expr DoThing> })
requiredContent = Just <Html.text "New">
content = [ KnownSlot { name = "icon", body = <M3e.Cem.Html.Icon.icon [...] []> } ]
```

Parser rules for ①:
- Recognize action-attr helpers (`onClick`, `href`, etc.) via Facts' action map
  and lift into `requiredAction` (removing from `attrs`).
- Recognize the first `Html.text`/`Html.node`-without-`slot=` child as
  `requiredContent` (component's `requiredSlots` includes `"unnamed"`).
- Recognize other children with a raw `slot="foo"` attribute and lift them
  into `content` via `slotRewrites` name mapping.
- Setter values are String literals (`"filled"`) — kept as `Node Expression`
  for pass-through; validity is checked at emit time against `enums`.

### 6.2 Parse.cem — from `M3e.Cem.*`

**Input:**
```elm
M3e.Cem.Button.button
    [ M3e.Cem.Button.variant M3e.Value.filled
    , M3e.Cem.Button.onClick DoThing
    ]
    [ Html.text "New"
    , M3e.Cem.Icon.icon
        [ M3e.Cem.Icon.name "add"
        , Html.Attributes.attribute "slot" "icon"
        ]
        []
    ]
```

Structurally identical to §6.1. Attr values are already token expressions
(`M3e.Value.filled`) rather than String literals — the parser records them
as-is; the emitter for ①/Html converts them back to strings via the `enums`
lookup.

### 6.3 Parse.standard — from `M3e.*`

**Input:**
```elm
M3e.Button.view
    [ M3e.Button.variant M3e.Value.filled
    , M3e.Button.onClick DoThing
    ]
    [ M3e.Button.label (Kit.text "New")
    , M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] [])
    ]
```

Cleanest parser — attr and slot setters are already normalized to camelCase
names. `M3e.Button.label` is recognized via Facts as the required-singular
slot (the `unnamed` slot's setter). `requiredContent` receives its argument.

### 6.4 Parse.record — from `M3e.Record.*`

**Input:**
```elm
M3e.Record.Button.view
    { content = Kit.text "New", action = M3e.Action.onClick DoThing }
    [ M3e.Record.Button.variant M3e.Value.filled ]
    [ M3e.Record.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
```

Parser reads the first-arg record via `Elm.Syntax.Expression.RecordExpr`,
extracting `content` and `action` into `requiredContent` /
`requiredAction = RecordStyle {raw}`. Attrs and content are parsed as in §6.3.

### 6.5 Parse.build — from `M3e.Build.*`

**Input:**
```elm
M3e.Build.Button.button
    { content = Kit.text "New", action = M3e.Action.onClick DoThing }
    |> M3e.Build.Button.variant M3e.Value.filled
    |> M3e.Build.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] [])
    |> M3e.Build.Button.build
```

Parser walks the `|>` pipeline via `Elm.Syntax.Expression.OperatorApplication`.
The head is the seed call (matching the component's snake-cased seed function
name, e.g. `button`). Terminal `build` is required — a pipeline without
`build` is a parse error (not a valid Build call). Setters in between become
`attrs`/`content` items based on their kind (attr setter or slot setter,
per Facts).

**Dynamic tail:** if the pipeline includes a segment that's a variable or
function call whose head isn't in this component's Facts (e.g.
`|> someHelper`), it's captured as an opaque `DynamicAttrTail`/
`DynamicContentTail` (whichever category makes sense given the surrounding
context) — and if the category can't be inferred, whole-node Seam escape
(§9).

## 7. Emitters (worked before/after per direction)

### 7.1 Emit.build — target ⑤ `M3e.Build.*`

**From Canonical (§6.1 example):**
```elm
M3e.Build.Button.button
    { content = Kit.text "New"
    , action = M3e.Action.onClick DoThing
    }
    |> M3e.Build.Button.variant M3e.Value.filled
    |> M3e.Build.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] [])
    |> M3e.Build.Button.build
```

Emission steps:
1. Emit seed: `M3e.Build.<Comp>.<seed> { <required> }`.
2. Convert `requiredAction`: `AttrStyle {name, value}` → `M3e.Action.<ctor> value`
   via the Facts action map. `RecordStyle {raw}` passes through.
3. Convert `requiredContent`: if source was Html/Cem (child is `Html`), wrap
   via `Seam.fromHtml` to get an `Element`. If source is Standard/Record/Build,
   pass through (already `Element`).
4. Emit attrs as pipeline setters, one `|> M3e.Build.<Comp>.<name> <value>`
   per `KnownAttr`. ⑤ has no attr-list seam, so any `EnumTokenLossy` /
   `EscapedAttr` / `DynamicAttrTail` triggers whole-node Seam escape (§9.6).
5. Emit slots as pipeline setters, one `|> M3e.Build.<Comp>.<name> <body>` per
   `KnownSlot`. Same rule: any `UnknownSlotName` / `EscapedContent` /
   `DynamicContentTail` triggers whole-node Seam escape.
6. Terminate: `|> M3e.Build.<Comp>.build`.

### 7.2 Emit.record — target ④ `M3e.Record.*`

**Output:**
```elm
M3e.Record.Button.view
    { content = Kit.text "New", action = M3e.Action.onClick DoThing }
    [ M3e.Record.Button.variant M3e.Value.filled ]
    [ M3e.Record.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
```

Emission steps:
1. Emit function head: `M3e.Record.<Comp>.view`.
2. Emit record arg with `content` and `action` fields; missing required →
   whole-node Seam escape.
3. Emit attrs list. `EnumTokenLossy` → `Seam.asAttribute
   (Html.Attributes.attribute "<name>" "<tokenText>")`. `DynamicAttrTail` →
   list-splice via `List.append`.
4. Emit content list. `EscapedContent` → `M3e.Content.raw (Seam.fromHtml ...)`.
   Same list-splice for `DynamicContentTail`.

### 7.3 Emit.standard — target ③ `M3e.*`

**Output:**
```elm
M3e.Button.view
    [ M3e.Button.variant M3e.Value.filled
    , M3e.Button.onClick DoThing
    ]
    [ M3e.Button.label (Kit.text "New")
    , M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] [])
    ]
```

Emission steps:
1. Emit function head: `M3e.<Comp>.view`.
2. Emit attrs list:
   - `KnownAttr` → `M3e.<Comp>.<name> <value>`
   - `requiredAction` (AttrStyle) → `M3e.<Comp>.<name> <value>` (spliced into
     attrs list); (RecordStyle) → `M3e.<Comp>.<mapped-name> <destructured-value>`
     via reverse action map, else Seam-wrap the action attribute.
   - `EnumTokenLossy` → `Seam.asAttribute (Html.Attributes.attribute ...)`
3. Emit content list, prepending `requiredContent` as the required-slot setter
   (e.g. `M3e.<Comp>.label <content>`).

### 7.4 Emit.cem — target ② `M3e.Cem.*`

**Output:**
```elm
M3e.Cem.Button.button
    [ M3e.Cem.Button.variant M3e.Value.filled
    , M3e.Cem.Button.onClick DoThing
    ]
    [ M3e.Element.toHtml (Kit.text "New")
    , M3e.Element.toHtml
        (M3e.Icon.view
            [ M3e.Icon.name "add"
            , M3e.Cem.Attr.slot "icon"
            ]
            []
        )
    ]
```

Emitter for ② returns `Html` children — Elements coming from Standard/Record/
Build parsers need `M3e.Element.toHtml` wrapping. Slot info gets injected as
a raw `Html.Attributes.attribute "slot" "<name>"` inside the child's attr
list (or via `M3e.Cem.Attr.slot`).

### 7.5 Emit.html — target ① `M3e.Cem.Html.*`

**Output:**
```elm
M3e.Cem.Html.Button.button
    [ M3e.Cem.Html.Button.variant "filled"
    , M3e.Cem.Html.Button.onClick DoThing
    ]
    [ Html.text "New"
    , M3e.Cem.Html.Icon.icon
        [ M3e.Cem.Html.Icon.name "add"
        , Html.Attributes.attribute "slot" "icon"
        ]
        []
    ]
```

Enum tokens on setter values need to be converted from `M3e.Value.<name>`
back to the underlying string (via Facts `enums` reverse map). Element
children need `M3e.Element.toHtml` (as in §7.4). Content-slot setters like
`M3e.Button.icon <element>` are unwrapped: the child moves into the child
list with `Html.Attributes.attribute "slot" "icon"` added.

## 8. Same-surface identity

When the source surface equals the rule's target, the rule short-circuits
before parse (identity — no error, no fix). This handles the "codebase already
at target" case cleanly.

## 9. Residue via Seam — where each failure escapes

The translator is total: every call site produces valid Elm output (either a
rewrite, a diagnostic-only error, or the original call left untouched).
Residue paths, ranked from lowest to highest-scope escape:

**9.1 EnumTokenLossy (uphill token that isn't in `enums`).**
- Target Html/Cem/Standard/Record: emit
  `Seam.asAttribute (Html.Attributes.attribute "<attr>" "<token>")` as one
  attr-list item.
- Target Build: no attr-list seam. Escape at **whole-node** level (§9.6).

**9.2 UnknownSlotName (uphill slot with no `slotRewrites` entry).**
- Target Html/Cem: keep child as-is with the raw `slot="<name>"` attribute.
- Target Standard/Record: emit
  `M3e.Content.slot "<name>" (Seam.fromHtml <body-as-html>)` — the target
  Content list gets an unrecognized-slot element via Seam.fromHtml with the
  slot name stamped through the Content constructor.
- Target Build: whole-node escape.

**9.3 EscapedAttr / EscapedContent (parser couldn't classify the sub-expr).**
- Attr → `Seam.asAttribute <raw>` (target Html/Cem/Standard/Record).
- Content → `M3e.Content.slot "" (Seam.fromHtml <raw>)` (target Standard/Record;
  empty slot name = unnamed default slot).
- Target Build: whole-node escape.

**9.4 DynamicAttrTail / DynamicContentTail (variable-bound list at end).**
- Target Html/Cem: `List.append <literal-attrs> <tail>` in the attr position.
- Target Standard/Record: same list-splice; the `<tail>` element type must
  match (Attr/Content) via elm's normal typing.
- Target Build: whole-node escape.

**9.5 Missing `requiredContent` or `requiredAction` at target ④/⑤.**
- No fabrication. Whole-node escape (§9.6).

**9.6 Whole-node Seam escape.** When any of the above hit the "target Build"
case or a required field can't be reconstructed, the entire call is rewritten
as:

```elm
Seam.fromHtml
    (M3e.Cem.Html.<Comp>.<name>
        [ <all-original-html-attrs> ]
        [ <all-original-html-children> ]
    )
```

(`Seam.fromHtml : Html msg -> Element supported msg` — implemented as
`M3e.Node.raw >> M3e.Element.fromNode`; using `Seam.fromHtml` directly keeps
the residue call short.)

The result has type `Element supported msg` — composable with every top-shape
target. `NoSeamOutsideAllowedModules` then flags it in the developer's next
review run; they hand-fix the underlying shape mismatch.

**Reconstructing the Html form.** For sources that are already Html
(surface = Html), the whole-node escape wraps the original call verbatim via
`Seam.fromHtml`. For sources at Cem/Standard/Record/Build, the parser
downhill-emits an Html form (calling into `Emit.html` internally) and then
wraps it via `Seam.fromHtml`. This reuses the Emit.html emitter — no
separate escape-only path needed.

## 10. Facts extension — the action map (config-driven)

The parser and emitter both need a per-component map:

- **Forward (attr → record):** given an attr-style setter name (`"onClick"`,
  `"href"`), yield the `M3e.Action.<ctor>` expression that produces the
  equivalent record-style action.
- **Reverse (record → attr):** given an `M3e.Action.<ctor>` expression head,
  yield the attr-setter name.

Add a new field `actionMap : List ( String, String )` to
`M3e.Review.Facts.Fact`. Each pair is `(attrSetterName, actionConstructorName)`,
e.g. `("onClick", "onClick")`, `("href", "link")`. The second element is the
short name — the emitter qualifies it as `M3e.Action.<name>`.

**Codegen agnosticism.** `elm-cem`'s generator does **not** hardcode
`M3e.Action.*` or any action semantics. The map is declared in the m3e
config file `config/slots.json` (or a peer config file merged in via
`--config-from`) as a new per-component field:

```json
{
  "Button": {
    "slots": { ... },
    "actionMap": [
      ["onClick", "onClick"],
      ["href", "link"]
    ]
  }
}
```

The generator reads this field generically (a `List (Pair String String)`
attached to each component) and emits it into `Facts.Fact.actionMap`. The
generic emission code doesn't reference `M3e.Action` or any m3e-specific
module; only the config file (which lives outside `elm-cem/`) knows the
target module. Same principle already used for `attrRewrites`/`slotRewrites`.

**Fallback and non-existence.** A component with no `actionMap` entry
(no attr-style action helpers, e.g. `Icon`) has `actionMap = []`. Attempting
to convert an unmapped attr-style action (e.g. some third-party
`Html.Events.onDoubleClick`) triggers whole-node Seam escape (§9.6).

**Reverse-map handling.** When translating from Record/Build to
Standard/Cem/Html, the emitter destructures the `M3e.Action.<ctor>` expression
to recover the attr-style form. For simple ctors like `M3e.Action.onClick msg`
this is one argument; for `M3e.Action.linkWith spec` it destructures the
record. If the source `RecordStyle {raw}` isn't a direct `M3e.Action.<ctor>`
application (e.g. it's a variable or a helper call), the emitter can't
destructure — the whole call goes to Seam escape (§9.6).

## 11. Interaction with other rules

- **`NoSeamOutsideAllowedModules`.** Fires on any Seam residue the translator
  emits, if the file isn't in the seam allow-list. This is the intended
  forcing function.
- **`PreferSpecificSlot`.** The translator emits fully specific setter names
  (never bare `variant`, always `variantButton` etc.); PreferSpecificSlot is a
  no-op on translator output. No fix-loop.
- **`ValidEnumValue`.** Similar — the translator's Cem/Standard/Record/Build
  emitters produce typed tokens (`M3e.Value.filled`), never string literals
  that could be invalid. No fix-loop.
- **`MissingRequiredAttribute` / `MissingRequiredSingularSlot`.** These fire
  when required fields are absent at the source's surface (③). Translator
  runs BEFORE — if translation moves to ④/⑤ where these are compile-enforced,
  the review rules become moot on that call site. If translation goes the
  other direction (④/⑤ → ③), the emitted ③ call contains the required
  pieces the record made explicit, so no missing-required.
- **`NoDebug.TodoOrToString`.** Translator emits no `Debug.todo`; irrelevant.
- **Fix conflicts.** elm-review presents each error's fix independently, and
  applying one fix re-runs all rules. If two rules propose overlapping ranges,
  elm-review reports the conflict and the developer resolves it. The
  translator's full-call replacement is a whole `Application` range, which
  typically dwarfs any inner setter-level fix from `PreferSpecificSlot` —
  applying the translator's fix erases the inner site and PreferSpecificSlot
  finds nothing to change on the emitted output. In practice these rules
  compose cleanly.

## 12. Testing plan

- **Unit tests** per rule under `review/tests/TranslateTo<X>Test.elm`, using
  `Review.Test`. Each rule test suite covers:
  - Each of the 4 sources → target directions with a representative component
    (Button — covers required record; Card — covers plain double-list;
    Icon — covers no slots).
  - Same-surface identity (source == target, no fix).
  - Residue paths: unknown enum token → Seam escape; unknown slot → Seam
    escape; missing required → whole-node Seam escape.
  - Dynamic tails (`myAttrs ++ [ ... ]`) — best-effort splice for non-Build
    targets, whole-node escape for Build.
  - Import fixes: target module added; unused source module removed.
- **Golden tests** under `elm-cem/tests/` for the Facts changes (Shape →
  Surface rename, `actionMap` field emission).
- **Type-behavior test** under `packages/m3e/tests/TranslateOutputTest.elm`
  that materializes emitter output as real Elm code and compiles it —
  smoke-tests every emitter's happy path.
- **Full build gate.** `pnpm run check` (real elm-pages build) is the
  authoritative gate — ADR 0012 caveat: green elm-review ≠ compilable app.

## 13. Definition of done

- Facts renamed: `Shape(..)` → `Surface(..)`; `shapes` → `surfaces`; `Html`
  and `Cem` constructors added.
- Facts extended: `actionMap : List (String, String)` per component.
- `config/slots.json` schema documented + populated for every component
  with attr-style action helpers.
- Generator emits `actionMap` from the config field, agnostic of m3e naming.
- `review/src/Translate/` shared library exists with Canonical, Parse,
  Emit, Residue, Rule modules.
- Five rules `TranslateTo{Html,Cem,Standard,Record,Build}` exist, thin
  wrappers over the shared library.
- Test coverage per §12.
- `elm-test-rs` green in `review/tests/`.
- `pnpm run check` green.
- Example rule invocation added (commented) in
  `review/src/CodegenReviewConfig.elm`.
- No rule enabled by default in `review/src/ReviewConfig.elm` — the rules
  are opt-in per project.

## 14. Deferred / follow-ups

- **Elm-format cleanup pass on emitted output.** Translator emits reasonable
  strings but doesn't run elm-format itself. Consumers run `elm-format` after
  `elm-review --fix`. Acceptable for now; a future pass could integrate
  elm-format via elm-review's `File.write` seam if it exists.
- **Comment preservation inside call sites.** Full-call `Fix.replaceRangeBy`
  loses in-call comments (`-- rest are optional`, etc.). Approach B from the
  brainstorm (subrange composition) would preserve them; defer until a
  concrete user complaint.
- **Non-view seed names.** ⑤ Build seed is `M3e.Build.<Comp>.<component>`
  (camelCased component name), not `.view`. Emitter derives the seed name
  from the Facts `component` field; no new fact needed.
- **Migrating the docs app to a canonical shape.** Separate task; docs stays
  mixed-surface.
- **Docs entry.** A per-shape usage docs page (E2 in epic #138) is a
  separate ship. This spec doesn't add docs content beyond the ReviewConfig
  example.

## 15. References

- Epic #138 — top-layer API-shape gradient.
- Issue #145 — this ship (D6 translator).
- ADR 0012 — codegen-aware elm-review.
- ADR 0013 (amended) — top-shape matrix and translation.
- Top-shape gradient design (§5 lattice): `2026-07-03-top-shape-gradient-design.md`.
- Coordination doc: `2026-07-03-epic-138-shipping-coordination.md`.
- Spike (Phase 0): `2026-07-03-build-shape-codegen-spike-{design,result}.md`.
- Generator: `elm-cem/codegen/Generate.elm`.
- Facts (current): `packages/m3e/src/M3e/Review/Facts.elm`.
- Rules (current pattern): `review/src/PreferSpecificSlot.elm`,
  `review/src/MissingRequiredAttribute.elm`.
- Config file: `config/slots.json` (m3e-specific; per-component fields).
