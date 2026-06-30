# Golden target — the validated three-layer model (2026-06-30)

Hand-written and **compile-verified** to the locked design in
[../docs/THREE_LAYER_PATTERN.md](../docs/THREE_LAYER_PATTERN.md). This is exactly
the shape the generator must emit. Supersedes the earlier old-IR sample.

`M3e/` — the model, bottom→top:
- `Cem/Html/{Button,Icon}.elm` — BOTTOM: partial-applied elm/html, no phantom types.
- `Cem/Attr.elm` — the IR attribute (`Attr capability msg`, deferred) + `forget` (capability erase).
- `Cem/{Button,Icon}.elm` — MIDDLE: phantom `Value`+capability attr setters; EAGER component reusing bottom.
- `Node.elm` / `Element.elm` — the IR (held middle-component + erased attrs + children) + phantom `Element` wrapper + `withSlot` + `toHtml`.
- `{Button,Icon}.elm` — TOP: lazy IR composition; attrs aliased from middle; typed-slot children.

Verified:
- `Positive.elm` — a valid composition. **Compiles.**
- `Neg1.elm` — `variant Value.small` (small ∉ closed Value row). **Rejected.**
- `Neg2.elm` — a foreign-capability attr (∉ button's attr caps). **Rejected.**
- `Neg3.elm` — a button as a child (button ∉ {icon,element} accepted kinds). **Rejected.**

Rule confirmed across all three phantom dimensions: **producer rows OPEN, consumer rows CLOSED.**
