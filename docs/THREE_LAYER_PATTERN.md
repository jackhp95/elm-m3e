# The three-layer pattern

> The definitive technical spec of the generated layer architecture. Locked
> 2026-06-30 after a long iterative alignment (see "How we got here" at the end —
> the wrong turns are part of the rationale). Companion: [THE_COMPLETE_EFFORT.md](THE_COMPLETE_EFFORT.md).

## The one idea: partial application + deferral

Everything is **partially-applied functions stored un-applied** in an IR, and the
**only eager point is `toHtml`** at the app root. The tag is baked into a
partially-applied `Html.node`; an attribute is a partially-applied
`Html.Attributes.attribute`; the IR holds those partial applications (plus child
IR) and runs them only when the tree is converted to opaque `Html`.

Two consequences fall out:

- **Strings exist exactly once.** No layer re-types `"m3e-button"` or `"variant"` —
  they're baked into the bottom's partial applications and passed *as functions*
  upward. (Rule of thumb: **if you define the same string to do the same thing on
  two layers, you did it wrong.**)
- **The IR is for composition, not introspection.** Its reason to exist is that
  you can still *add* a `slot=` to an element to associate it with a parent
  *before* it collapses to opaque `Html`. Opaque `Html` cannot be composed; the
  IR + phantom types can, and guarantee the composition is valid.

## The escape gradient

```
M3e.*            top     — lazy IR for components AND attrs; phantom kind rows; only toHtml is eager
  └ M3e.Cem.*    middle  — lazy IR attributes; EAGER component (→ Html); phantom Value + capability rows
      └ M3e.Cem.Html.*  bottom — partial applications of elm/html; NO phantom types; fully applied → Html
          └ raw elm/html — the floor; opaque
```

Each outer layer **reuses the one below** (passes its functions, never re-derives
them). Going deeper = less safety, less convenience, more control. The correct way
and the easy way are the same way (the top); you *can* drop down, but it takes an
explicit, louder step. This mirrors the library's own html → element → child shape
and is the same escapable-but-convenient gradient the whole library is built on.

## The layers, in full (Button)

### Bottom — `M3e.Cem.Html.Button` — partial applications, no phantom types
```elm
button  = Html.node "m3e-button"                  -- List (Html.Attribute msg) -> List (Html msg) -> Html msg
variant = Html.Attributes.attribute "variant"     -- String -> Html.Attribute msg
slot    = Html.Attributes.attribute "slot"
```
Every function, fully applied, returns `Html` / `Html.Attribute`. The strings live
here and nowhere else.

### Middle — `M3e.Cem.Button` — captures attribute application as IR; phantom types start here
```elm
type Attr capability msg
    = Attr (() -> Html.Attribute msg)             -- `capability` is phantom; holds an un-applied bottom fn

attribute : (a -> Html.Attribute msg) -> a -> Attr capability msg
attribute fn value = Attr (\() -> fn value)       -- collect the parts; DO NOT apply

toAttribute : Attr capability msg -> Html.Attribute msg
toAttribute (Attr run) = run ()

-- (1) Value row guards the value; (2) OPEN capability row names what this attr IS:
variant : Value { v | elevated : Supported, filled : Supported, tonal : Supported, outlined : Supported, text : Supported }
       -> Attr { c | variant : Supported } msg
variant v = attribute Bottom.variant (Value.toString v)

disabled : Bool -> Attr { c | disabled : Supported } msg
disabled b = attribute Bottom.disabled (boolString b)

slot : String -> Attr { c | slot : Supported } msg
slot = attribute Bottom.slot

-- EAGER component: now fully applied, evaluate the held attrs and hand to the BOTTOM:
button : List (Attr { variant : Supported, disabled : Supported, slot : Supported } msg) -> List (Html msg) -> Html msg
button attrs children = Bottom.button (List.map toAttribute attrs) children
```
The middle does **not** eagerly evaluate attributes when they're written —
`variant Value.filled` just collects `(Bottom.variant, "filled")` into an `Attr`.
They are evaluated to opaque `Html.Attribute` only when the **component** is fully
applied. The middle is where phantom types are introduced.

### Top — `M3e.Button` — defers component composition too; only `toHtml` is eager
```elm
type Element supported msg
    = Element (Node msg)                           -- `supported` is phantom: the composition guarantee

type Node msg                                      -- the IR. Holds a HELD middle component + middle attrs + child IR.
    = Node { component : List (Cem.Attr {} msg) -> List (Html msg) -> Html msg
           , attrs : List (Cem.Attr {} msg)
           , children : List (Node msg) }
    | Text String
    | Raw (Html msg)

button :
    List (Cem.Attr { variant : Supported, disabled : Supported, slot : Supported } msg)   -- (2) closed attr caps
    -> List (Element { icon : Supported, element : Supported } msg)                        -- (3) closed accepted kinds
    -> Element { s | button : Supported } msg                                              -- (3) "I AM a button"
button attrs children =
    Element (Node { component = Cem.button, attrs = erase attrs, children = List.map toNode children })

withSlot : String -> Element supported msg -> Element supported msg   -- ADD-only; preserves kind
withSlot name (Element node) = Element (addAttr (Cem.slot name) node)

leadingIcon : … -> Element { s | icon : Supported } msg               -- a blessed composition helper
leadingIcon attrs children = withSlot "leading" (icon attrs children)

toHtml : Element supported msg -> Html msg          -- THE ONLY EAGER POINT
-- walks the IR, applies every held function, builds opaque Html.
```

### Using it
```elm
M3e.button
    [ M3e.Cem.variant Value.filled ]            -- variant ∈ button caps ✓ ; filled ∈ variant values ✓
    [ M3e.leadingIcon [] [ M3e.text "★" ]       -- Element {icon} ∈ button accepted kinds ✓
    , M3e.text "Save"
    ]
    -- still 100% IR. Only M3e.toHtml builds opaque Html.
    --
    -- M3e.Cem.variant Value.small   → COMPILE ERROR (small ∉ variant Value row)
    -- a foreign attr in that list   → COMPILE ERROR (∉ button attr caps)
    -- M3e.Card.view … in that list  → COMPILE ERROR (card ∉ button accepted kinds)
```

## The three phantom rows (all extensible; all on public signatures — NON-NEGOTIABLE)

| # | row | guards | producer / consumer | introduced |
|---|---|---|---|---|
| 1 | `Value { v | … }` | which **values** an enum attr accepts | token open / setter input | middle |
| 2 | `Attr { c | capability }` | which **attrs** a component admits | setter **open** / component **closed** | middle |
| 3 | `Element { s | kind }` | which **kind** an element IS (slots) | child **open** / slot **closed** | top |

The IR erases these to uniform thunks *internally* (so the `Node` list is
homogeneous) — but **erasure happens behind the public signatures**, so every
composition a consumer writes is fully type-checked. The guarantees never leave the
boundary. **Without the rows on the return types the composition guarantees fall
apart — this is the foundation of the whole effort, not an option.**

## Composition rules
- **Add-only.** Composition only *adds* attributes (e.g. `withSlot`); it never
  changes or removes. The types prevent ever needing to.
- **Predictable conflicts.** If an attribute is set twice, `elm/html`'s natural
  last-wins resolution gives a predictable result — no dedup machinery needed.
- **Blessed helpers.** Common valid compositions ship as helpers (`leadingIcon`),
  which return the right kind so they still fit the right slots.

## Lazy vs eager, precisely
- **Bottom**: eager. Fully-applied functions → `Html`.
- **Middle**: attrs lazy (collected), **component eager** (evaluates attrs → `Html`
  when applied). Returns `Html`.
- **Top**: everything lazy (held in the IR). Returns `Element`. Eager only at `toHtml`.

## Introspection (deferred, optional)
The current `M3e.Node` was introspection-oriented (`findProperty`/`findAttribute`).
The new IR is **composition-oriented**; introspection is **not essential** and is
intentionally deferred. The seam is left so it can be added later (store the
structured `(name, value)` alongside the thunk) without changing components — but
it is not built now. Verification meanwhile leans on **compile-green of positive
AND negative composition probes** (which directly prove the phantom rows) plus the
browser contract harness for runtime behavior.

## How we got here (the wrong turns are rationale)
The model was reached by correcting a sequence of my wrong understandings; each
correction encodes a rule worth keeping:
1. *Each layer must reuse the one below* — not three layers independently calling
   raw constructors (which made the middle look like the bottom and the top "bypass"
   to atoms).
2. *Lazy(top) / eager(middle, bottom)* — the distinction is when `Html` is built.
3. *Capture the parts, not the opaque result* — store the function + value
   un-applied; this is what kills string duplication (reuse the function).
4. *It's all partial application* — `Html.node "tag"` and `attribute "name"` are
   partial applications; pass them as first-class values; only `toHtml` applies.
5. *The IR is for composition (slot association), not introspection* — add-only,
   `Html` last-wins for conflicts.
6. *The phantom rows are non-negotiable on every return type* — without them the
   composition guarantees collapse.
