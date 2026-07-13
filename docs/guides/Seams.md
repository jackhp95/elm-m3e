# Seams

A **seam** is any crossing point where a value from outside the typed IR
enters it. The IR itself is opaque — you cannot construct an `Element` from
raw `Html` by accident, because `fromNode` lives only in `Markup.Element.Internal`
and that module is not re-exported from the public `M3e.Element`. Every crossing
into the IR must go through one of the two mechanisms described here.

This guide covers the **two sanctioned brand crossings** that the cross-CEM
initiative established (CX5). For a broader overview of the seam boundary and
why it exists, see [`DESIGN.md §4`](../DESIGN.md) and the
[`decisions.md CX5 entry`](../decisions.md#cx5--seams-are-loud-coercions-are-config-blessed-sugar).

## The two mechanisms

### 1. `recast` — the general loud crossing

`Seam.recast` is the general escape valve. It takes an `Element` with any kind
row and re-stamps it with any other kind row:

```elm
-- In your designated Seam module (docs/kit/Seam.elm or your app's equivalent):
text : String -> M3e.Element.Element { s | text : M3e.Kind.Brand } msg
text str =
    M3e.Seam.text str
```

`recast` makes no semantic claim — it just changes the phantom row. It is loud
by construction (you must write it explicitly) and greppable (one function name,
not an operator). `NoSeamOutsideAllowedModules` restricts all `recast` calls to
the modules you declare in `ReviewConfig.elm`, so the design-system owner can
audit every crossing point.

Use `recast` for crossings that have no stable, recurring semantic identity: a
one-off layout adapter, a foreign component you are integrating temporarily, a
crossing you expect to resolve when the library grows a proper slot.

### 2. `M3e.Coerce.*` — config-blessed typed crossings

Some brand crossings recur with a stable identity. A Chip acting as a button is
a design-system decision, not an accident. For these, the `_coerce` block in
`config/slots.json` declares the crossing, and the generator emits a typed
function in `M3e.Coerce`:

```elm
-- config/slots.json:
-- "_coerce": [{"from": "Chip", "fromKind": "chip", "to": "button", "name": "asButton"}]

-- Generated: src/M3e/Coerce.elm
asButton :
    M3e.Element.Element { k | chip : M3e.Kind.Brand } msg
    -> M3e.Element.Element { s | button : M3e.Kind.Brand } msg
asButton =
    M3e.Element.Internal.toNode >> M3e.Element.Internal.fromNode
```

A named coercion differs from `recast` in two ways:

- **It is typed**: the from-kind is specific (`chip : M3e.Kind.Brand`), not
  polymorphic. Only an element that is already typed as a Chip will pass.
- **It is config-tracked**: it appears in `_coerce`, so the tool and reviewers
  can find every declared crossing without grepping the application code.

Use named coercions for crossings that appear in multiple places with the same
intent. If you reach for `recast` on the same crossing three times, that is a
sign it deserves a named coercion.

## What is NOT a seam crossing

The `Markup.Atoms` constructors (`text`, `link`, `label`, `iconDecorative`,
`iconLabeled`) produce `Markup.Kind.Shared`-typed elements. These are not seam
crossings — they are atoms with a declared shared role, and any m3e slot that
opts in with the matching `shared:*` config entry accepts them. The kind system
allows the unification; no `recast` or coercion is needed.

Similarly, m3e components in any closed private-tier slot accept their own brand
(`M3e.Kind.Brand`) freely — that is just the normal kind row system working.

## The review rules

Two elm-review-cem rules enforce seam discipline:

- **`ExtractToSeam`** — flags a direct `fromNode`/`fromHtml` call outside the
  declared seam modules and suggests moving it to the seam.
- **`NoSeamOutsideAllowedModules`** — flags use of `recast` (or any seam
  stamper) outside the set of modules you declare as allowed. Config:

```elm
NoSeamOutsideAllowedModules.rule
    { seamModules = [ "Seam" ]
    , allowedModules = [ "Seam", "Kit" ]
    }
```

Both rules take the same config shape (aligned in CX9). Together they ensure
every crossing is inside an auditable adapter layer, not scattered across
application modules.

## Choosing between the two mechanisms

| Situation | Use |
|---|---|
| Crossing with a stable, recurring semantic identity (Chip as button) | Named coercion in `_coerce` |
| One-off crossing, no recurring semantic identity | `recast` in the seam module |
| Atom producer (text, link, label, icon) entering a compatible slot | Neither — atoms flow freely via shared kind |
| Wrapping raw `Html` into the IR | `recast` in the seam module (via `fromHtml`) |

The design principle: if you are uncertain which to use, start with `recast`.
If the same crossing recurs with consistent intent, promote it to a named coercion.
The test is whether the crossing has a name that another developer would recognize.
