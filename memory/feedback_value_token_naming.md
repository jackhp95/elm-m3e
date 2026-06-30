---
name: M3e.Value token naming — bare axis-neutral names
description: Design decision for the M3e.Value shared-token facade (#54); use bare names, not axis-prefixed
type: feedback
---

Use **bare, axis-neutral token names** in `M3e.Value` (`Value.large`, `Value.filled`, `Value.rounded`) — NOT axis-prefixed names (`Value.sizeLarge`, `Value.variantRounded`).

**Why:** A `Value` token carries only the emitted *string*; the component supplies the *attribute name* (`size`, `variant`, `shape`). So one `Value.rounded` correctly serves both a variant axis (Icon) and a shape axis (Button/IconButton) because both emit the literal `"rounded"`. Cross-axis collisions (`rounded`, `square`, `auto`) all emit identical strings across the axes that share them, so a single token is correct for all. Prefixing the names would break this sharing and force duplicate tokens per axis. User explicitly confirmed this was the right call.

**How to apply:** When adding new shared tokens (e.g. the shape axis after variant), keep names bare and reuse an existing token whenever the emitted string matches — do not introduce an axis-qualified duplicate. The consequence to accept: a token is structurally untyped w.r.t. axis, so a component whose closed row admits a token will accept it even if the upstream web component doesn't honor that combination (see the SplitButton 5-member widening leak). A future opt-in "typed attribute" helper (token → named Attr) could re-tighten this without abandoning bare-name sharing.
